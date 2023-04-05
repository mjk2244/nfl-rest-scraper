from bs4 import BeautifulSoup
import requests
import pandas as pd
import time

# these teams had a bye week in week 1, 2, or 17
#skipped_teams = ['/teams/tam/2017.htm', '/teams/mia/2017.htm', '/teams/htx/2008.htm', '/teams/nor/2001.htm', '/teams/tam/2001.htm', '/teams/crd/2001.htm', '/teams/sdg/2001.htm', '/teams/pit/2001.htm', '/teams/cin/2000.htm', '/teams/cle/2000.htm', '/teams/sdg/1999.htm', '/teams/mia/1992.htm', '/teams/nwe/1992.htm', '/teams/cle/1999.htm', '/teams/crd/2000.htm']
skipped_teams = []
def tnf_weeks(year: int) -> pd.DataFrame:
    # make HTTP request for the seasons page
    # e.g. https://www.pro-football-reference.com/years/2022/
    r = make_request_season(year)

    # parse HTML using BeautifulSoup
    soup = get_soup(r)
    

    #some teams have a few, some have none 
    #if first game is thurs, don't necessarily have short rest so don't count
    #don't count last thurs also
    #hashmap that maps from season num to number of games
    #1-17, then 1-18 from 2020 onwards
    #if year > 2020, 1-18 else 1-17
    #delete week 18 anyways
    #last week of season doesn't have any TNF games
    #throw out both back-to-back TNF, TNF after bye
    #keep count of instances of tossing out TNF


    # gather each team's href
    teams = []
    # AFC teams
    for anchor in soup.find_all('tbody')[0].find_all('a'):
        # filter out teams that had week 1, 2, or 17 bye week
        href = anchor.get('href')
        if href not in skipped_teams: teams.append(href)
    # NFC teams
    for anchor in soup.find_all('tbody')[1].find_all('a'):
        href = anchor.get('href')
        if href not in skipped_teams: teams.append(href)

    # set up the data frame
    data = {'year': [],
            'team': [],
            'week_1': [],
            'win_pct_1': [],
            'home_team_1': [],
            'opp_1': [],
            'opp_win_pct_1': [],
            'result_1': [],
            'pf_1': [],
            'pa_1': [],
            'yds_1': [],
            'opp_yds_1': [],
            'tnf': [],
            }
            #'week_2': [],
            #'win_pct_2': [],
            #'home_team_2': [],
            #'opp_2': [],
            #'opp_win_pct_2': [],
            #'result_2': [],
            #'pf_2': [],
            #'pa_2': [],
            #'yds_2': [],
            #'opp_yds_2': []}

    df = pd.DataFrame(data)

    for team in teams:
        # make HTTP request for individual team's page
        # e.g. https://www.pro-football-reference.com/teams/buf/2022.htm
        r = make_request_team(team)

        # parse HTML using BeautifulSoup
        soup = get_soup(r)

        # get team name
        team = soup.title.text.split(' ')
        if team[3] == 'Rosters,': team = team[1] + ' ' + team[2]
        else: team = team[1] + ' ' + team[2] + ' ' + team[3]

        # collect the data
        df = collect_data(df, soup, year, team)

        # 3 second delay
        time.sleep(3)
    
    return df

# helper function to make a HTTP request for a season page
def make_request_season(season: int):
    url = 'https://www.pro-football-reference.com/years/' + str(season) + '/'
    return requests.get(url)

# helper function to turn an HTTP response into a BeautifulSoup object
def get_soup(response):
    return BeautifulSoup(response.text, 'html.parser')

# helper function to make a HTTP request for a team page
def make_request_team(team_href: str):
    url = 'https://www.pro-football-reference.com/' + team_href
    return requests.get(url)

def collect_data(df: pd.DataFrame, soup: BeautifulSoup, year: int, team: str) -> pd.DataFrame:
    

    
    #get thurs
    p = 0
    #while rows[p].find('td', {'data-stat': 'game_day_of_week'}).text != 'Thu':
    #    p += 1
    rows = soup.find_all('tbody')[1].find_all('tr')
    numTeams = 18
    if year < 2021:
        numTeams = 17
    for p in range(0, len(rows)):#numTeams):
        week_before = p - 1
        week_after = p + 1

        if week_before >= 0 and week_after < numTeams-1:#len(rows)-2:  
            if (rows[week_before].find('td', {'data-stat': 'game_day_of_week'}).text != 'Thu' 
            and rows[week_after].find('td', {'data-stat': 'game_day_of_week'}).text != 'Thu' 
            and rows[p].find('td', {'data-stat': 'game_day_of_week'}).text == 'Thu' 
            and rows[p-1].find('td', {'data-stat': 'opp'}).text != 'Bye Week' 
            and rows[p+1].find('td', {'data-stat': 'opp'}).text != 'Bye Week'):
                week_1 = int(rows[p].find('th', {'data-stat': 'week_num'}).text)
                #print("boop\n")
                #print(rows[p-1])
                #print("beep\n")
                #print(rows[p])
                if rows[p-1].find('td', {'data-stat': 'opp'}).text != 'Bye Week':
                    record = rows[p - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
                else:
                    record = rows[p - 2].find('td', {'data-stat': 'team_record'}).text.split('-')
                if len(record) > 2:
                    win_pct_1 = float(int(record[0]) / (int(record[0]) + int(record[1]) + int(record[2])))
                else:
                    win_pct_1 = float(int(record[0]) / (int(record[0]) + int(record[1])))
                if rows[p].find('td', {'data-stat': 'game_location'}).text == '@': home_team_1 = False
                else: home_team_1 = True
                opp_1 = rows[p].find('td', {'data-stat': 'opp'}).text

                # calculate opponent's win pct
                
                #if rows[p].find('td', {'data-stat': 'opp'}).text != 
                opp_href = rows[p].find('td', {'data-stat': 'opp'}).find('a').get('href')
                time.sleep(3)
                r = make_request_team(opp_href)
                soup = get_soup(r)

                rows2 = soup.find_all('tbody')[1].find_all('tr')
                #print("bink\n")
                #print(rows2[p-1])
                #print("bonk\n")
                #print(rows2[p])
                #print("donk\n")
                #print(rows2[p-2])

                if soup.find_all('tbody')[1].find_all('tr')[p-1].find('td', {'data-stat': 'opp'}).text != 'Bye Week':
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[p-1].find('td', {'data-stat': 'team_record'}).text.split('-')
                else:
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[p-2].find('td', {'data-stat': 'team_record'}).text.split('-')

                if len(opp_record) > 2:
                    opp_win_pct_1 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1]) + int(opp_record[2])))
                else:
                    opp_win_pct_1 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))
                
                result = rows[p].find('td', {'data-stat': 'game_outcome'}).text
                if result == 'W':
                    result_1 = 1
                else:
                    result_1 = 0
                pf_1 = int(rows[p].find('td', {'data-stat': 'pts_off'}).text)
                pa_1 = int(rows[p].find('td', {'data-stat': 'pts_def'}).text)
                yds_1 = int(rows[p].find('td', {'data-stat': 'yards_off'}).text)
                opp_yds_1 = int(rows[p].find('td', {'data-stat': 'yards_def'}).text)
                tnf = 1
                df.loc[len(df.index)] = [year, team, week_1, win_pct_1, home_team_1, opp_1, opp_win_pct_1, result_1, pf_1, pa_1, yds_1, opp_yds_1, tnf]

                #get week after TNF
                if rows[week_after].find('td', {'data-stat': 'opp'}).text == 'Bye Week':
                    week_after += 1
                week_2 = int(rows[week_after].find('th', {'data-stat': 'week_num'}).text)
                record = rows[p].find('td', {'data-stat': 'team_record'}).text.split('-')
                win_pct_2 = float(int(record[0]) / (int(record[0]) + int(record[1])))
                if rows[week_after].find('td', {'data-stat': 'game_location'}).text == '@': home_team_2 = False
                else: home_team_2 = True
                opp_2 = rows[week_after].find('td', {'data-stat': 'opp'}).text

                # calculate opponent's win pct
                opp_href = rows[week_after].find('td', {'data-stat': 'opp'}).find('a').get('href')

                time.sleep(3)
                r = make_request_team(opp_href)
                soup = get_soup(r)
                if soup.find_all('tbody')[1].find_all('tr')[p].find('td', {'data-stat': 'opp'}).text != 'Bye Week':
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[p].find('td', {'data-stat': 'team_record'}).text.split('-')
                else:
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[p-1].find('td', {'data-stat': 'team_record'}).text.split('-')
                #else:
                #    opp_record = soup.find_all('tbody')[1].find_all('tr')[post_bye - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
                if len(opp_record) > 2:
                    opp_win_pct_2 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1]) + int(opp_record[2])))
                else:
                    opp_win_pct_2 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))
                result = rows[week_after].find('td', {'data-stat': 'game_outcome'}).text
                if result == 'W':
                    result_2 = 1
                else:
                    result_2 = 0

                pf_2 = int(rows[week_after].find('td', {'data-stat': 'pts_off'}).text)
                pa_2 = int(rows[week_after].find('td', {'data-stat': 'pts_def'}).text)
                yds_2 = int(rows[week_after].find('td', {'data-stat': 'yards_off'}).text)
                opp_yds_2 = int(rows[week_after].find('td', {'data-stat': 'yards_def'}).text)
                tnf_2 = 0
                print("p")
                print(p)
                print("team")
                print(team)
                print([year, team, week_1, win_pct_1, home_team_1, opp_1, opp_win_pct_1, result_1, pf_1, pa_1, yds_1, opp_yds_1, week_2, win_pct_2, home_team_2, opp_2, opp_win_pct_2, result_2, pf_2, pa_2, yds_2, opp_yds_2])

                df.loc[len(df.index)] = [year, team, week_2, win_pct_2, home_team_2, opp_2, opp_win_pct_2, result_2, pf_2, pa_2, yds_2, opp_yds_2, tnf_2]
    return df
 
def main():
    for i in range(2006, 2023):
        tnf_weeks(i).to_csv('TNF_Weeks_' + str(i) + '.csv')

if __name__ == '__main__':
    main()
