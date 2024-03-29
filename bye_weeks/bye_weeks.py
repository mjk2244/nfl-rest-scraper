from bs4 import BeautifulSoup
import requests
import pandas as pd
import time

# these teams had a bye week in week 1, 2, or 17
skipped_teams = ['/teams/tam/2017.htm', '/teams/mia/2017.htm', '/teams/htx/2008.htm', '/teams/nor/2001.htm', '/teams/tam/2001.htm', '/teams/crd/2001.htm', '/teams/sdg/2001.htm', '/teams/pit/2001.htm', '/teams/cin/2000.htm', '/teams/cle/2000.htm', '/teams/sdg/1999.htm', '/teams/mia/1992.htm', '/teams/nwe/1992.htm', '/teams/cle/1999.htm', '/teams/crd/2000.htm']

def bye_weeks(year: int) -> pd.DataFrame:
    # make HTTP request for the seasons page
    # e.g. https://www.pro-football-reference.com/years/2022/
    r = make_request_season(year)

    # parse HTML using BeautifulSoup
    soup = get_soup(r)
    
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
            'week_2': [],
            'win_pct_2': [],
            'home_team_2': [],
            'opp_2': [],
            'opp_win_pct_2': [],
            'result_2': [],
            'pf_2': [],
            'pa_2': [],
            'yds_2': [],
            'opp_yds_2': []}

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
    rows = soup.find_all('tbody')[1].find_all('tr')

    # find the bye week
    p = 0
    while rows[p].find('td', {'data-stat': 'opp'}).text != 'Bye Week':
        p += 1

    pre_bye = p - 1
    post_bye = p + 1

    week_1 = int(rows[pre_bye].find('th', {'data-stat': 'week_num'}).text)
    record = rows[pre_bye - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
    if len(record) > 2:
        win_pct_1 = float(int(record[0]) / (int(record[0]) + int(record[1]) + int(record[2])))
    else:
        win_pct_1 = float(int(record[0]) / (int(record[0]) + int(record[1])))
    if rows[pre_bye].find('td', {'data-stat': 'game_location'}).text == '@': home_team_1 = False
    else: home_team_1 = True
    opp_1 = rows[pre_bye].find('td', {'data-stat': 'opp'}).text

    # calculate opponent's win pct
    opp_href = rows[pre_bye].find('td', {'data-stat': 'opp'}).find('a').get('href')
    time.sleep(3)
    r = make_request_team(opp_href)
    soup = get_soup(r)
    if soup.find_all('tbody')[1].find_all('tr')[pre_bye - 1].find('td', {'data-stat': 'opp'}).text == 'Bye Week':
        opp_record = soup.find_all('tbody')[1].find_all('tr')[pre_bye - 2].find('td', {'data-stat': 'team_record'}).text.split('-')
    else:
        opp_record = soup.find_all('tbody')[1].find_all('tr')[pre_bye - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
    if len(opp_record) > 2:
        opp_win_pct_1 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1]) + int(opp_record[2])))
    else:
        opp_win_pct_1 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))
    
    result_1 = rows[pre_bye].find('td', {'data-stat': 'game_outcome'}).text
    pf_1 = int(rows[pre_bye].find('td', {'data-stat': 'pts_off'}).text)
    pa_1 = int(rows[pre_bye].find('td', {'data-stat': 'pts_def'}).text)
    yds_1 = int(rows[pre_bye].find('td', {'data-stat': 'yards_off'}).text)
    opp_yds_1 = int(rows[pre_bye].find('td', {'data-stat': 'yards_def'}).text)

    week_2 = int(rows[post_bye].find('th', {'data-stat': 'week_num'}).text)
    record = rows[pre_bye].find('td', {'data-stat': 'team_record'}).text.split('-')
    win_pct_2 = float(int(record[0]) / (int(record[0]) + int(record[1])))
    if rows[post_bye].find('td', {'data-stat': 'game_location'}).text == '@': home_team_2 = False
    else: home_team_2 = True
    opp_2 = rows[post_bye].find('td', {'data-stat': 'opp'}).text

    # calculate opponent's win pct
    opp_href = rows[post_bye].find('td', {'data-stat': 'opp'}).find('a').get('href')

    time.sleep(3)
    r = make_request_team(opp_href)
    soup = get_soup(r)
    if soup.find_all('tbody')[1].find_all('tr')[post_bye - 1].find('td', {'data-stat': 'opp'}).text == 'Bye Week':
        opp_record = soup.find_all('tbody')[1].find_all('tr')[post_bye - 2].find('td', {'data-stat': 'team_record'}).text.split('-')
    else:
        opp_record = soup.find_all('tbody')[1].find_all('tr')[post_bye - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
    if len(opp_record) > 2:
        opp_win_pct_2 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1]) + int(opp_record[2])))
    else:
        opp_win_pct_2 = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))
    result_2 = rows[post_bye].find('td', {'data-stat': 'game_outcome'}).text
    pf_2 = int(rows[post_bye].find('td', {'data-stat': 'pts_off'}).text)
    pa_2 = int(rows[post_bye].find('td', {'data-stat': 'pts_def'}).text)
    yds_2 = int(rows[post_bye].find('td', {'data-stat': 'yards_off'}).text)
    opp_yds_2 = int(rows[post_bye].find('td', {'data-stat': 'yards_def'}).text)

    df.loc[len(df.index)] = [year, team, week_1, win_pct_1, home_team_1, opp_1, opp_win_pct_1, result_1, pf_1, pa_1, yds_1, opp_yds_1, week_2, win_pct_2, home_team_2, opp_2, opp_win_pct_2, result_2, pf_2, pa_2, yds_2, opp_yds_2]
    return df
 
def main():
    for i in range(1990, 2023):
        bye_weeks(i).to_csv('Bye_Weeks_' + str(i) + '.csv')

if __name__ == '__main__':
    main()
