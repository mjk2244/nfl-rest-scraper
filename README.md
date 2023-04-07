# nfl-rest-scraper
This repo is for a final project in Dr. Michelle Levine's COMS4995 - Empirical Methods of Data Science course at Columbia University. It includes the code we used to build our web scrapers as well as the datasets they produced.

We have structured our work in three separate directories—bye_weeks, distance, and tnf—based on the different datasets we are analyzing. More details on each dataset can be found below.

## [Bye Weeks](./bye_weeks)
This dataset tracks each team's performance in the game directly before (**pre-bye**) and the game directly after their bye week (**post-bye**). Our data begins in 1990 (when bye weeks were first introduced into the NFL) and ends in 2022 (the most recent NFL season).

To access our entire dataset, click [here](./bye_weeks/data/separated/bye_weeks_all.csv). To access subframes for each individual season, click [here](./bye_weeks/data/separated/individual_seasons). The source code for our web scraper can be found [here](./bye_weeks/bye_weeks2.py).

The features in this dataset include:  
- `year`: the season in question (1990-2022)
- `team`: the team in question (string)
- `post_bye`: whether the game was **pre-bye** (0) or **post-bye** (1)
- `week`: the week of the NFL season in which the game took place (2-16)
- `win_pct`: `team`'s win percentage before the game (0.000-1.000)
- `home_team`: whether or not `team` was the home team (1 for home, 0 for away)
- `opp`: `team`'s opponent in the game (string)
- `opp_win_pct`: `opp`'s win percentage before the game (0.000-1.000)
- `result`: whether `team` lost or won the game (1 if win, 0 otherwise)
- `pf`: number of points `team` scored in the game (int)
- `pa`: number of points `team` allowed in the game (int)
- `yds`: number of yards `team` recorded in the game (int)
- `opp_yds`: number of yards `team` allowed in the game (int)

## [Distance](./distance)
This dataset tracks the results of every NFL game played from 1990-2022, aiming to analyze how distance traveled and time zones traversed affect road teams' performances.

To access our entire dataset, click [here](./distance/data/distance_all.md). To access subframes for each individual season, click [here](./distance/data/individual_seasons). The source code for our web scraper can be found [here](./distance/distance.py).

The features in this dataset include:
- `year`: the season in question (1990-2022)
- `team`: the road team (string)
- `week`: the week the game was played (2-18)
- `opp`: the home team (string)
- `distance`: distance, in miles, that `team` had to travel to reach the game (from airport to airport) (float)
- `time_zone_diff`: the number of time zones `team` had to traverse to reach the game  
(negative values indicate east-to-west travel, while positive values indicate west-to-east travel) (int)
- `win_pct`: `team`'s win percentage going into the game in question (0.000-1.000)
- `opp_win_pct`: `opp`'s win percentage going into the game in question (0.000-1.000)
- `result`: whether `team` won the game in question (1 if win, 0 otherwise)
- `pf`: number of points `team` scored in the game in question (int)
- `pa`: number of points `opp` scored in the game in question (int)
- `yds`: number of yards `team` recorded in the game in question (int)
- `opp_yds`: number of yards `opp` recorded in the game in question (int)

## [Thursday Night Football](./tnf)
This dataset tracks each team's performance in the Thursday Night game following a Sunday game (**short rest**) and the game directly after that Thursday Night week (**long rest**). Our data begins in 2006 and ends in 2022 (the most recent NFL season).

To access our entire dataset, click [here](./tnf/data/separated/tnf_all.csv). To access subframes for each individual season, click [here](./tnf/data/separated/individual_seasons). The source code for our web scraper can be found [here](./tnf/tnf.py).

The features in this dataset include:  
- `year`: the season in question (2006-2022)
- `team`: the team in question (string)
- `week_1`: the week of the NFL season in which `team`'s game was played (2-16)
- `win_pct_1`: `team`'s win percentage going into the game (0.000-1.000)
- `home_team_1`: whether or not `team` was the home team in the game (boolean value)
- `opp_1`: `team`'s opponent in the game (string)
- `opp_win_pct_1`: `opp_1`'s win percentage before the game (0.000-1.000)
- `result_1`: whether `team` lost or won the game (1 if win, 0 otherwise)
- `pf_1`: number of points `team` scored in the game (int)
- `pa_1`: number of points `team` allowed in the game (int)
- `yds_1`: number of yards `team` recorded in the game (int)
- `opp_yds_1`: number of yards `team` allowed in the game (int)
- `tnf`: whether the game was on (1) or after (0) TNF

## Group Members
Robert Gao - `rzg2107`  
Matt Kim - `mjk2244`  
Aaron Ouyang - `ao2764`  
Evan Tong - `eht2126`
