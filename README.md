# nfl-rest-scraper
This repo is for a final project in Dr. Michelle Levine's COMS4995 - Empirical Methods of Data Science course at Columbia University. It includes the code we used to build our web scrapers as well as the datasets they produced.

We have structured our work in three separate directories—bye_weeks, distance, and tnf—based on the different datasets we are analyzing. More details on each dataset can be found below.

## [Bye Weeks](./bye_weeks)
This dataset tracks each team's performance in the game directly before (**pre-bye**) and the game directly after their bye week (**post-bye**). Our data begins in 1990 (when bye weeks were first introduced into the NFL) and ends in 2022 (the most recent NFL season).

To access our entire dataset, click [here](./bye_weeks/data/bye_weeks_all.csv). To access subframes for each individual season, click [here](./bye_weeks/data/individual_seasons). The source code for our web scraper can be found [here](./bye_weeks/bye_weeks.py).

The features in this dataset include:  
- `year`: the season in question
- `team`: the team in question
- `week_1`: the week of the NFL season in which `team`'s **pre-bye** game was played
- `win_pct_1`: `team`'s win percentage going into its **pre-bye** game
- `home_team_1`: whether or not `team` was the home team in its **pre-bye** game (boolean value)
- `opp_1`: `team`'s opponent in its **pre-bye** game
- `opp_win_pct_1`: `opp_1`'s win percentage before `team`'s **pre-bye** game
- `result_1`: whether `team` lost or won its **pre-bye** game
- `pf_1`: number of points `team` scored in its **pre-bye** game
- `pa_1`: number of points `team` allowed in its **pre-bye** game
- `yds_1`: number of yards `team` recorded in its **pre-bye** game
- `opp_yds_1`: number of yards `team` allowed in its **pre-bye** game
- `week_2`: the week of the NFL season in which `team`'s **post-bye** game was played
- `win_pct_2`: `team`'s win percentage going into its **post-bye** game
- `home_team_2`: whether or not `team` was the home team in the **post-bye** game (boolean value)
- `opp_2`: `team`'s opponent in its **post-bye** game
- `opp_win_pct_2`: `opp_2`'s win percentage before `team`'s **post-bye** game
- `result_2`: whether `team` lost or won its **post-bye** game
- `pf_2`: number of points `team` scored in its **post-bye** game
- `pa_2`: number of points `team` allowed in its **post-bye** game
- `yds_2`: number of yards `team` recorded in its **post-bye** game
- `opp_yds_2`: number of yards `team` allowed in its **post-bye** game

## [Distance](./distance)
This dataset tracks the results of every NFL game played from 1990-2022, aiming to analyze how distance travelled and time zones traversed affect road teams' performances.

To access our entire dataset, click [here](./distance/data/distance_all.md). To access subframes for each individual season, click [here](./distance/data/individual_seasons). The source code for our web scraper can be found [here](./distance/distance.py).

The features in this dataset include:
- `year`: the season in question
- `team`: the road team
- `week`: the week the game was played
- `opp`: the home team
- `distance`: distance, in miles, that `team` had to travel to reach the game (from airport to airport)
- `time_zone_diff`: the number of time zones `team` had to traverse` to reach the game (negative values indicate east-to-west travel, while positive values indicate west-to-east travel)
- `win_pct`: `team`'s win percentage going into the game in question
- `opp_win_pct`: `opp`'s win percentage going into the game in question
- `result`: whether `team` won the game in question
- `pf`: number of points `team` scored in the game in question
- `pa`: number of points `opp` scored in the game in question
- `yds`: number of yards `team` recorded in the game in question
- `opp_yds`: number of yards `opp` recorded in the game in question

## [Thursday Night Football](./tnf)
TODO: FILL THIS OUT WITH DETAILS ABOUT THE DATASET

## Group Members
Robert Gao - `rzg2107`  
Matt Kim - `mjk2244`  
Aaron Ouyang - `ao2764`  
Evan Tong - `eht2126`
