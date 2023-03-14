from bs4 import BeautifulSoup
import requests
import pandas as pd
import time
from haversine import haversine, Unit

locations = {'Phoenix': {'latitude': 33.4352, 'longitude': 112.0101, 'airport': 'PHX', 'time_zone': 'M'},
'Chicago': {'latitude': 41.9803, 'longitude': 87.9090, 'airport': 'ORD', 'time_zone': 'C'},
'Green Bay': {'latitude': 44.4923, 'longitude': 88.1278, 'airport': 'GRB', 'time_zone': 'C'},
'New York': {'latitude': 40.6895, 'longitude': 74.1745, 'airport': 'EWR', 'time_zone': 'E'},
'Detroit': {'latitude': 42.2162, 'longitude': 83.3554, 'airport': 'DTW', 'time_zone': 'E'},
'Washington DC': {'latitude': 38.9531, 'longitude': 77.4565, 'airport': 'IAD', 'time_zone': 'E'},
'Philadelphia': {'latitude': 39.9526, 'longitude': 75.1652, 'airport': 'PHL', 'time_zone': 'E'},
'Pittsburgh': {'latitude': 40.4919, 'longitude': 80.2352, 'airport': 'PIT', 'time_zone': 'E'},
'Los Angeles': {'latitude': 33.9416, 'longitude': 118.4085, 'airport': 'LAX', 'time_zone': 'P'},
'San Francisco': {'latitude': 37.3639, 'longitude': 121.9289, 'airport': 'SJC', 'time_zone': 'P'},
'Cleveland': {'latitude': 41.4058, 'longitude': 81.8539, 'airport': 'CLE', 'time_zone': 'E'},
'Indianapolis': {'latitude': 39.7169, 'longitude': 86.2956, 'airport': 'IND', 'time_zone': 'E'},
'Dallas': {'latitude': 32.8998, 'longitude': 97.0403, 'airport': 'DFW', 'time_zone': 'C'},
'Kansas City': {'latitude': 39.3036, 'longitude': 94.7093, 'airport': 'MCI', 'time_zone': 'C'},
'Los Angeles': {'latitude': 33.9416, 'longitude': 118.4085, 'airport': 'LAX', 'time_zone': 'P'},
'Denver': {'latitude': 39.8564, 'longitude': 104.6764, 'airport': 'DEN', 'time_zone': 'M'},
'New York': {'latitude': 40.6895, 'longitude': 74.1745, 'airport': 'EWR', 'time_zone': 'E'},
'Providence': {'latitude': 41.7235, 'longitude': 71.4270, 'airport': 'PVD', 'time_zone': 'E'},
'Las Vegas': {'latitude': 36.0840, 'longitude': 115.1537, 'airport': 'LAS', 'time_zone': 'P'},
'Nashville': {'latitude': 36.1263, 'longitude': 86.6774, 'airport': 'BNA', 'time_zone': 'C'},
'Buffalo': {'latitude': 42.9397, 'longitude': 78.7295, 'airport': 'BUF', 'time_zone': 'E'},
'Minneapolis': {'latitude': 44.8848, 'longitude': 93.2223, 'airport': 'MSP', 'time_zone': 'C'},
'Atlanta': {'latitude': 33.6407, 'longitude': 84.4277, 'airport': 'ATL', 'time_zone': 'E'},
'Miami': {'latitude': 26.0742, 'longitude': 80.1506, 'airport': 'FLL', 'time_zone': 'E'},
'New Orleans': {'latitude': 29.9911, 'longitude': 90.2592, 'airport': 'MSY', 'time_zone': 'C'},
'Cincinnati': {'latitude': 39.0508, 'longitude': 84.6673, 'airport': 'CVG', 'time_zone': 'E'},
'Seattle': {'latitude': 47.4480, 'longitude': 122.3088, 'airport': 'SEA', 'time_zone': 'P'},
'Tampa Bay': {'latitude': 27.9772, 'longitude': 82.5311, 'airport': 'TPA', 'time_zone': 'E'},
'Charlotte': {'latitude': 35.2144, 'longitude': 80.9473, 'airport': 'CLT', 'time_zone': 'E'},
'Jacksonville': {'latitude': 30.4941, 'longitude': 81.6879, 'airport': 'JAX', 'time_zone': 'E'},
'Baltimore': {'latitude': 39.1774, 'longitude': 76.6684, 'airport': 'BWI', 'time_zone': 'E'},
'Houston': {'latitude': 29.9902, 'longitude': 95.3368, 'airport': 'IAH', 'time_zone': 'C'},
'Oakland': {'latitude': 37.7126, 'longitude': 122.2197, 'airport': 'OAK', 'time_zone': 'P'},
'San Diego': {'latitude': 32.7338, 'longitude': 117.1933, 'airport': 'SAN', 'time_zone': 'P'},
'St. Louis': {'latitude': 38.7499, 'longitude': 90.3748, 'airport': 'STL', 'time_zone': 'C'}}

cities = {'Arizona Cardinals': 'Phoenix',
'Chicago Bears': 'Chicago',
'Green Bay Packers': 'Green Bay',
'New York Giants': 'New York',
'Detroit Lions': 'Detroit',
'Washington Commanders': 'Washington DC',
'Washington Football Team': 'Washington DC',
'Washington Redskins': 'Washington DC',
'Philadelphia Eagles': 'Philadelphia',
'Pittsburgh Steelers': 'Pittsburgh',
'Los Angeles Chargers': 'Los Angeles',
'San Francisco 49ers': 'San Francisco',
'Houston Oilers': 'Houston',
'Cleveland Browns': 'Cleveland',
'Indianapolis Colts': 'Indianapolis',
'Dallas Cowboys': 'Dallas',
'Kansas City Chiefs': 'Kansas City',
'Los Angeles Rams': 'Los Angeles',
'Denver Broncos': 'Denver',
'New York Jets': 'New York',
'New England Patriots': 'Providence',
'Las Vegas Raiders': 'Las Vegas',
'Tennessee Titans': 'Nashville',
'Tennessee Oilers': 'Nashville',
'Phoenix Cardinals': 'Phoenix',
'Los Angeles Raiders': 'Los Angeles',
'Buffalo Bills': 'Buffalo',
'Minnesota Vikings': 'Minneapolis',
'Atlanta Falcons': 'Atlanta',
'Miami Dolphins': 'Miami',
'New Orleans Saints': 'New Orleans',
'Cincinnati Bengals': 'Cincinnati',
'Seattle Seahawks': 'Seattle',
'Tampa Bay Buccaneers': 'Tampa Bay',
'Carolina Panthers': 'Charlotte',
'Jacksonville Jaguars': 'Jacksonville',
'Baltimore Ravens': 'Baltimore',
'Houston Texans': 'Houston',
'Oakland Raiders': 'Oakland',
'San Diego Chargers': 'San Diego',
'St. Louis Rams': 'St. Louis'}

time_zones = {'P': 4,
              'M': 3,
              'C': 2,
              'E': 1}

def distance(year: int) -> pd.DataFrame:
    # make HTTP request for the seasons page
    # e.g. https://www.pro-football-reference.com/years/2022/
    r = make_request_season(year)

    # parse HTML using BeautifulSoup
    soup = get_soup(r)
    
    # gather each team's href
    teams = []
    # AFC teams
    for anchor in soup.find_all('tbody')[0].find_all('a'): teams.append(anchor.get('href'))
    # NFC teams
    for anchor in soup.find_all('tbody')[1].find_all('a'): teams.append(anchor.get('href'))

    # set up the data frame
    data = {'year': [],
            'week': [],
            'team': [],
            'opp': [],
            'distance': [],
            'time_zone_diff': [],
            'win_pct': [],
            'opp_win_pct': [],
            'result': [],
            'pf': [],
            'pa': [],
            'yds': [],
            'opp_yds': []}

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
    url = 'https://www.pro-football-reference.com/years/'+ str(season) + '/'
    return requests.get(url)

# helper function to turn an HTTP response into a BeautifulSoup object
def get_soup(response):
    return BeautifulSoup(response.text, 'html.parser')

# helper function to make a HTTP request for a team page
def make_request_team(team_href: str):
    url = 'https://www.pro-football-reference.com/' + team_href
    return requests.get(url)

def collect_data(df: pd.DataFrame, soup: BeautifulSoup, year: int, team: str) -> pd.DataFrame:
    print(team)
    # each game's row
    games = soup.find_all('tbody')[1].find_all('tr')

    # remove playoff games
    j = 0
    # while games[j].find('td', {'data-stat': 'opp'}).text != 'Bye Week': j+= 1
    # j += 1
    while j < len(games) and games[j].find('td', {'data-stat': 'game_date'}).text != 'Playoffs': j += 1
    for k in range(j, len(games)): games.pop()

    for i in range(len(games)):
        # skip week 1, bye weeks, and canceled games
        if games[i].find('td', {'data-stat': 'opp'}).text != 'Bye Week' and games[i].find('td', {'data-stat': 'boxscore_word'}).text != 'canceled' and games[i].find('th', {'data-stat': 'week_num'}).text != '1':
            # only collecting data for road games
            if games[i].find('td', {'data-stat': 'game_location'}).text == '@':
                opp = games[i].find('td', {'data-stat': 'opp'}).text
                distance = calculate_distance(locations[cities[team]], locations[cities[opp]])
                time_zone_diff = calculate_time_zone_diff(locations[cities[team]], locations[cities[opp]])
                
                if games[i - 1].find('td', {'data-stat': 'opp'}).text == 'Bye Week':
                    record = games[i - 2].find('td', {'data-stat': 'team_record'}).text.split('-')
                else: record = games[i - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
                if len(record) > 2: win_pct = float(int(record[0]) / (int(record[0]) + int(record[1]) + int(record[2])))
                else: win_pct = float(int(record[0]) / (int(record[0]) + int(record[1])))

                # calculate opponent's win pct
                opp_href = games[i].find('td', {'data-stat': 'opp'}).find('a').get('href')
                time.sleep(2)
                r = make_request_team(opp_href)
                soup = get_soup(r)
                if soup.find_all('tbody')[1].find_all('tr')[i - 1].find('td', {'data-stat': 'opp'}).text == 'Bye Week':
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[i - 2].find('td', {'data-stat': 'team_record'}).text.split('-')
                    opp_win_pct = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))
                else:
                    opp_record = soup.find_all('tbody')[1].find_all('tr')[i - 1].find('td', {'data-stat': 'team_record'}).text.split('-')
                    opp_win_pct = float(int(opp_record[0]) / (int(opp_record[0]) + int(opp_record[1])))

                week = int(games[i].find('th', {'data-stat': 'week_num'}).text)
                result = games[i].find('td', {'data-stat': 'game_outcome'}).text
                pf = int(games[i].find('td', {'data-stat': 'pts_off'}).text)
                pa = int(games[i].find('td', {'data-stat': 'pts_def'}).text)
                yds = int(games[i].find('td', {'data-stat': 'yards_off'}).text)
                opp_yds = int(games[i].find('td', {'data-stat': 'yards_def'}).text)

                df.loc[len(df.index)] = [year, week, team, opp, distance, time_zone_diff, win_pct, opp_win_pct, result, pf, pa, yds, opp_yds]
    return df

# helper function to calculate the haversine distance between two cities
def calculate_distance(city1: dict, city2: dict) -> float:
    coordinates1 = (city1['latitude'], city1['longitude'])
    coordinates2 = (city2['latitude'], city2['longitude'])
    return haversine(coordinates1, coordinates2, unit = Unit.MILES)

def calculate_time_zone_diff(city1: dict, city2: dict) -> int:
    return time_zones[city1['time_zone']] - time_zones[city2['time_zone']]

def main():
    for i in range(2002, 2023):
        distance(i).to_csv('distance_' + str(i) + '.csv')

if __name__ == '__main__':
    main()
