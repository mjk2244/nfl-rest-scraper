distance <- read.csv(file.choose())
#file: distance_all.csv

distance

fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=distance)
summary(fit_yds)
fit_yds2 <- lm(yds ~ distance + win_pct + opp_win_pct + week, data=distance)
summary(fit_yds2)

fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=distance)
summary(fit_opp_yds)

fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=distance)
summary(fit_pf)

fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=distance)
summary(fit_pa)

fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=distance)
summary(fit_result)

#logit regression -> not significant!
logit_result <- glm(result ~ distance + win_pct + opp_win_pct, data=distance, family="binomial")
summary(logit_result)

#probit regression -> not significant!
probit_result <- glm(result ~ distance + win_pct + opp_win_pct, data=distance, family="binomial"(link = "probit"))
summary(probit_result)

#chi_squared regression -> idk does not list significance?
library(nnet)
chisq_result <- multinom(result ~ distance + win_pct + opp_win_pct, data=distance)
summary(chisq_result)

ydsa <- lm(yds ~ distance, data=distance)
summary(ydsa)
ydsb <- lm(yds ~ distance + win_pct, data=distance)
summary(ydsb)
ydsc <- lm(yds ~ distance + opp_win_pct, data=distance)
summary(ydsc)

opp_ydsa <- lm(opp_yds ~ distance, data=distance)
summary(opp_ydsa)
opp_ydsb <- lm(opp_yds ~ distance + win_pct, data=distance)
summary(opp_ydsb)
opp_ydsc <- lm(opp_yds ~ distance + opp_win_pct, data=distance)
summary(opp_ydsc)

pfa <- lm(pf ~ distance, data=distance)
summary(pfa)
pfb <- lm(pf ~ distance + win_pct, data=distance)
summary(pfb)
pfc <- lm(pf ~ distance + opp_win_pct, data=distance)
summary(pfc)

paa <- lm(pa ~ distance, data=distance)
summary(paa)
pab <- lm(pa ~ distance + win_pct, data=distance)
summary(pab)
pac <- lm(pa ~ distance + opp_win_pct, data=distance)
summary(pac)

resulta <- lm(result ~ distance, data=distance)
summary(resulta)
resultb <- lm(result ~ distance + win_pct, data=distance)
summary(resultb)
resultc <- lm(result ~ distance + opp_win_pct, data=distance)
summary(resultc)

homeaway <- read.csv(file.choose())
#file: distance_all (home:away).csv

ha_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=homeaway)
summary(ha_yds)
ha_yds2 <- lm(yds ~ distance + win_pct + opp_win_pct + away, data=homeaway)
summary(ha_yds2)
ha_yds3 <- lm(yds ~ away + win_pct + opp_win_pct, data=homeaway)
summary(ha_yds3)

ha_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=homeaway)
summary(ha_opp_yds)
ha_opp_yds2 <- lm(opp_yds ~ distance + win_pct + opp_win_pct + away, data=homeaway)
summary(ha_opp_yds2)
ha_opp_yds3 <- lm(opp_yds ~ away + win_pct + opp_win_pct, data=homeaway)
summary(ha_opp_yds3)

#ha_tzd <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=homeaway)
#summary(ha_tzd)
#ha_tzd2 <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct + away, data=homeaway)
#summary(ha_tzd2)
#ha_tzd3 <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=homeaway)
#summary(ha_tzd3)

ha_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=homeaway)
summary(ha_pf)
ha_pf2 <- lm(pf ~ distance + win_pct + opp_win_pct + away, data=homeaway)
summary(ha_pf2)
ha_pf3 <- lm(pf ~ away + win_pct + opp_win_pct, data=homeaway)
summary(ha_pf3)

ha_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=homeaway)
summary(ha_pa)
ha_pa2 <- lm(pa ~ distance + win_pct + opp_win_pct + away, data=homeaway)
summary(ha_pa2)
ha_pa3 <- lm(pa ~ away + win_pct + opp_win_pct, data=homeaway)
summary(ha_pa3)

ha_result <- lm(result ~ distance + win_pct + opp_win_pct, data=homeaway)
summary(ha_result)
ha_result2 <- lm(result ~ distance + win_pct + opp_win_pct + away, data=homeaway)
summary(ha_result2)
ha_result3 <- lm(result ~ away + win_pct + opp_win_pct, data=homeaway)
summary(ha_result3)

logit_ha_result <- glm(result ~ distance + win_pct + opp_win_pct, data=homeaway, family="binomial")
summary(logit_ha_result)
logit_ha_result2 <- glm(result ~ distance + win_pct + opp_win_pct + away, data=homeaway, family="binomial")
summary(logit_ha_result2)
logit_ha_result3 <- glm(result ~ away + win_pct + opp_win_pct, data=homeaway, family="binomial")
summary(logit_ha_result3)

probit_ha_result <- glm(result ~ distance + win_pct + opp_win_pct, data=homeaway, family="binomial"(link = "probit"))
summary(probit_ha_result)
probit_ha_result2 <- glm(result ~ distance + win_pct + opp_win_pct + away, data=homeaway, family="binomial"(link = "probit"))
summary(probit_ha_result2)
probit_ha_result3 <- glm(result ~ away + win_pct + opp_win_pct, data=homeaway, family="binomial"(link = "probit"))
summary(probit_ha_result3)

no_covid <- distance[distance$year != 2020,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=no_covid)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=no_covid)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=no_covid)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=no_covid)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=no_covid)
summary(fit_result)

fifteen <- distance[distance$year == 2015,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=fifteen)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=fifteen)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=fifteen)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=fifteen)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=fifteen)
summary(fit_result)

sixteen <- distance[distance$year == 2016,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=sixteen)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=sixteen)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=sixteen)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=sixteen)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=sixteen)
summary(fit_result)

seventeen <- distance[distance$year == 2017,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=seventeen)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=seventeen)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=seventeen)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=seventeen)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=seventeen)
summary(fit_result)

eighteen <- distance[distance$year == 2018,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=eighteen)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=eighteen)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=eighteen)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=eighteen)
summary(fit_pa) #significant at 0.01!
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=eighteen)
summary(fit_result)

nineteen <- distance[distance$year == 2019,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=nineteen)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=nineteen)
summary(fit_opp_yds) #significant at 0.01!
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=nineteen)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=nineteen)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=nineteen)
summary(fit_result)

twenty <- distance[distance$year == 2020,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_opp_yds) 
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_result)

twenty <- homeaway[homeaway$year == 2020,]
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_opp_yds) 
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_pa)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=twenty)
summary(fit_result)

fit_yds <- lm(yds ~ distance + time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_yds)
fit_opp_yds <- lm(opp_yds ~ distance + time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_opp_yds)
fit_pf <- lm(pf ~ distance + time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_pf)
fit_pa <- lm(pa ~ distance + time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_pa)
fit_result <- lm(result ~ distance + time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_result)

library(stargazer)
fit_result <- lm(result ~ distance + win_pct + opp_win_pct, data=distance)
logit_result <- glm(result ~ distance + win_pct + opp_win_pct, data=distance, family="binomial")
fit_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=distance)
fit_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=distance)
fit_yds <- lm(yds ~ distance + win_pct + opp_win_pct, data=distance)
fit_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=distance)
stargazer(fit_result, logit_result, fit_pf, fit_pa, fit_yds, fit_opp_yds,
          title = "Table 3: Travel Distance (mi) Regression Model Output",
          #title.center = TRUE,
          align = TRUE,
          type = "text")

#result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + year + team - 1, data = distance)
#summary(result_fixed)
install.packages("plm")
library(plm)
distance_fixed <- plm.data(distance, index=c("team","year"))
result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(result_fixed)
pf_fixed <- lm(pf ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(pf_fixed)
pa_fixed <- lm(pa ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(pa_fixed) #significant at p < 0.1 ?!
yds_fixed <- lm(yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(yds_fixed)
opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(opp_yds_fixed) #significant at p < 0.05 ?!

distance_fixed <- plm.data(distance, index=c("team","year"))
#result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance_fixed)
summary(result_fixed)
#pf_fixed <- lm(pf ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
pf_fixed <- lm(pf ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance_fixed)
summary(pf_fixed)
#pa_fixed <- lm(pa ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
pa_fixed <- lm(pa ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance_fixed)
summary(pa_fixed) #significant at p < 0.1 ?!
#yds_fixed <- lm(yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
yds_fixed <- lm(yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance_fixed)
summary(yds_fixed)
#opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance_fixed)
summary(opp_yds_fixed) #significant at p < 0.05 ?!

#everything above this better, this following regression not necessarily accurate!
library(plm)
homeaway_fixed <- plm.data(homeaway, index=c("team","year"))
ha_result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
summary(ha_result_fixed)
ha_pf_fixed <- lm(pf ~ distance + win_pct + opp_win_pct + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
summary(ha_pf_fixed)
ha_pa_fixed <- lm(pa ~ distance + win_pct + opp_win_pct + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
summary(ha_pa_fixed)
ha_yds_fixed <- lm(yds ~ distance + win_pct + opp_win_pct + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
summary(ha_yds_fixed)
ha_opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
summary(ha_opp_yds_fixed) #significant at p < 0.1 ?!

#ha_pa_fixed <- lm(pa ~ distance + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
#summary(ha_pa_fixed)
#ha_opp_yds_fixed <- lm(opp_yds ~ distance + away + factor(team) + factor(year) - 1, data = homeaway_fixed)
#summary(ha_opp_yds_fixed)
#homeaway_fixed <- plm.data(homeaway, index=c("team","year","away"))
#ha_opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + factor(away) + factor(team) + factor(year) - 1, data = homeaway_fixed)
#summary(ha_opp_yds_fixed) #significant at p < 0.1 ?!

homeaway <- read.csv(file.choose())
away <- homeaway[homeaway$away == 1,]
away_result <- lm(result ~ distance + win_pct + opp_win_pct data=away)
summary(away_result)
logit_away_result <- glm(result ~ distance + win_pct + opp_win_pct, data=away, family="binomial")
summary(logit_away_result)
away_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=away)
summary(away_pf)
away_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=away)
summary(away_pa)
away_pa <- lm(yds ~ distance + win_pct + opp_win_pct, data=away)
summary(away_pa)
away_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=away)
summary(away_opp_yds)

data(distance)
anova_result <- aov(result ~ distance + win_pct + opp_win_pct, data = distance)
summary(anova_result)
anova_pf <- aov(pf ~ distance + win_pct + opp_win_pct, data = distance)
summary(anova_pf)
anova_pa <- aov(pa ~ distance + win_pct + opp_win_pct, data = distance)
summary(anova_pa)
anova_yds <- aov(yds ~ distance + win_pct + opp_win_pct, data = distance)
summary(anova_yds)
anova_opp_yds <- aov(opp_yds ~ distance + win_pct + opp_win_pct, data = distance)
summary(anova_opp_yds)

library(plm)
away_fixed <- plm.data(away, index=c("team","year"))
away_result_fixed <- lm(result ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_result_fixed)
logit_away_result_fixed <- glm(result ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed, family="binomial")
summary(logit_away_result_fixed)
away_pf_fixed <- lm(pf ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pf_fixed)
away_pa_fixed <- lm(pa ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pa_fixed) #significant p = 0.08
away_pa_fixed <- lm(yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pa_fixed)
away_opp_yds_fixed <- lm(opp_yds ~ distance + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_opp_yds_fixed) #significant p = 0.03

home <- homeaway[homeaway$away == 0,]
home_result <- lm(result ~ distance + win_pct + opp_win_pct, data=home)
summary(home_result)
logit_home_result <- glm(result ~ distance + win_pct + opp_win_pct, data=home, family="binomial")
summary(logit_home_result)
home_pf <- lm(pf ~ distance + win_pct + opp_win_pct, data=home)
summary(home_pf)
home_pa <- lm(pa ~ distance + win_pct + opp_win_pct, data=home)
summary(home_pa)
home_pa <- lm(yds ~ distance + win_pct + opp_win_pct, data=home)
summary(home_pa)
home_opp_yds <- lm(opp_yds ~ distance + win_pct + opp_win_pct, data=home)
summary(home_opp_yds)

summary(away$result)
summary(home$result)
summary(away$pf)
summary(home$pf)
summary(away$pa)
summary(home$pa)
summary(away$yds)
summary(home$yds)
summary(away$opp_yds)
summary(home$opp_yds)

#felm regression!
#regression4921.1 <- lm(homicide100k ~ port + post + port*post + factor(city) + factor(year) - 1, data=df4921.3)
  #regression_fixed <- plm.data(df4921.3, index=c("city","year"))
#felm(formula = homicide100k ~ port + post + port*post | year + city | 0 | city, data = df4921.3)

install.packages("lfe")
library(lfe)
#model <- felm(y ~ x1 + x2 | id, data = data)
away_result_felm <- felm(result ~ distance + win_pct + opp_win_pct | team + year, data=away)
summary(away_result_felm) #same as factor version of fixed effects!
away_pf_felm <- felm(pf ~ distance + win_pct + opp_win_pct | team + year, data=away)
summary(away_pf_felm) #same as factor version of fixed effects!
away_pa_felm <- felm(pa ~ distance + win_pct + opp_win_pct | team + year, data=away)
summary(away_pa_felm) #significant p = 0.08
away_yds_felm <- felm(yds ~ distance + win_pct + opp_win_pct | team + year, data=away)
summary(away_yds_felm)
away_opp_yds_felm <- felm(opp_yds ~ distance + win_pct + opp_win_pct | team + year, data=away)
summary(away_opp_yds_felm) #significant p = 0.0337
#away$result_logit <- log(away$result / (1 - away$result))
#logit_away_result_felm <- felm(result_logit ~ distance + win_pct + opp_win_pct | team + year , data=away)
#summary(logit_away_result_felm)
  #Error in quantile.default(x$residuals) : 
  #missing values and NaN's not allowed if 'na.rm' is FALSE
  #In addition: Warning message:
  #In summary.felm(logit_away_result_felm) : can't compute cluster F-test

library(stargazer)
result_felm <- felm(result ~ distance + win_pct + opp_win_pct | team + year, data=distance)
summary(result_felm)
pf_felm <- felm(pf ~ distance + win_pct + opp_win_pct | team + year, data=distance)
summary(pf_felm)
pa_felm <- felm(pa ~ distance + win_pct + opp_win_pct | team + year, data=distance)
summary(pa_felm)
yds_felm <- felm(yds ~ distance + win_pct + opp_win_pct | team + year, data=distance)
summary(yds_felm)
opp_yds_felm <- felm(opp_yds ~ distance + win_pct + opp_win_pct | team + year, data=distance)
summary(opp_yds_felm)
stargazer(result_felm, pf_felm, pa_felm, yds_felm, opp_yds_felm,
          title = "Travel Distance (mi) Fixed Effects Regression Model Output",
          #title = "Table X: Travel Distance (mi) Fixed Effects Regression Model Output",
          #title.center = TRUE,
          align = TRUE,
          type = "text")

sd(distance$opp_yds)
distance_000s = distance$distance / 1000
result_felm_000s <- felm(result ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
summary(result_felm_000s)
pf_felm_000s <- felm(pf ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
summary(pf_felm_000s)
pa_felm_000s <- felm(pa ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
summary(pa_felm_000s)
yds_felm_000s <- felm(yds ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
summary(yds_felm_000s)
opp_yds_felm <- felm(opp_yds ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
summary(opp_yds_felm)


library(ggplot2)
library(lfe)
opp_yds_felm <- felm(opp_yds ~ distance + win_pct + opp_win_pct | team + year, data=distance)
coef_data <- data.frame(variable = row.names(summary(opp_yds_felm)$coef),
                        coef = summary(opp_yds_felm)$coef[, 1],
                        se = summary(opp_yds_felm)$coef[, 2])
coef_data$variable <- factor(coef_data$variable, levels = c("distance", "win_pct", "opp_win_pct"))
ggplot(coef_data, aes(x = variable, y = coef, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = coef - 1.96 * se, ymax = coef + 1.96 * se),
                width = 0.2, position = position_dodge(width = 1)) +
  labs(x = "Variable", y = "Δ in Yards Allowed per 1-Unit Change in IV", fill = NULL) +
  ggtitle("Yards Allowed vs Distance Regression Coefficients") +
  theme(plot.title = element_text(size = 16, face = "bold")) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x = element_text(size=16)) +
  theme(axis.title.y = element_text(size=16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(axis.text = element_text(size = 12))

library(ggplot2)
library(lfe)
opp_yds_felm_000s <- felm(opp_yds ~ distance_000s + win_pct + opp_win_pct | team + year, data=distance)
coef_data <- data.frame(variable = row.names(summary(opp_yds_felm_000s)$coef),
                        coef = summary(opp_yds_felm_000s)$coef[, 1],
                        se = summary(opp_yds_felm_000s)$coef[, 2])
coef_data$variable <- factor(coef_data$variable, levels = c("distance_000s", "win_pct", "opp_win_pct"))
ggplot(coef_data, aes(x = variable, y = coef, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = coef - 1.96 * se, ymax = coef + 1.96 * se),
                width = 0.2, position = position_dodge(width = 1)) +
  labs(x = "Variable", y = "Δ in Yards Allowed per 1-Unit Change in IV", fill = NULL) +
  ggtitle("Distance vs Yards Allowed Regression Coefficients") +
  theme(plot.title = element_text(size = 16, face = "bold")) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x = element_text(size=16)) +
  theme(axis.title.y = element_text(size=16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(axis.text = element_text(size = 12))

home_result_felm <- felm(result ~ distance + win_pct + opp_win_pct | team + year, data=home)
summary(home_result_felm) #same as factor version of fixed effects!
home_pf_felm <- felm(pf ~ distance + win_pct + opp_win_pct | team + year, data=home)
summary(home_pf_felm) #same as factor version of fixed effects!
home_pa_felm <- felm(pa ~ distance + win_pct + opp_win_pct | team + year, data=home)
summary(home_pa_felm)
home_yds_felm <- felm(yds ~ distance + win_pct + opp_win_pct | team + year, data=home)
summary(home_yds_felm)
home_opp_yds_felm <- felm(opp_yds ~ distance + win_pct + opp_win_pct | team + year, data=home)
summary(home_opp_yds_felm) #significant p = 0.0337

away$result_pct = away$result * 100
home$result_pct = home$result * 100
#ttest_result <- t.test(away$result_pct, home$result_pct)
  #Error in var(x) : 'x' is NULL
ttest_result <- t.test(away$result, home$result)
mean(home$result)
mean(away$result)
result_bar <- c(mean(home$result_pct), mean(away$result_pct))
  labels <- c("Home","Away")
  colors <- c("blue", "red")
  barplot(result_bar, names.arg = labels, ylim = c(0, 100), ylab = "Percent of Games Won", 
        main = "Win Percentage (Home vs. Away)", col = colors, border = "black",
        cex.main = 1.5, cex.lab = 1.5, cex.axis = 1.5)
  abline(h = 50, lty = 2)

ttest_pf <- t.test(away$pf, home$pf)
mean(home$pf)
mean(away$pf)
  boxplot(home$pf, away$pf, names = c("Home", "Away"), col = c("blue", "red"), 
        main = "Points Scored (Home vs. Away)", ylab = "Points Scored",
        cex.main = 1.5, cex.lab = 1.5, cex.axis = 1.5)
  #abline(h = ttest_pf$estimate, col = "black", lwd = 2)

ttest_yds <- t.test(away$yds, home$yds)
  boxplot(home$yds, away$yds, names = c("Home", "Away"), col = c("blue", "red"), 
        main = "Yards Gained (Home vs. Away)", ylab = "Yards Gained",
        cex.main = 1.5, cex.lab = 1.5, cex.axis = 1.5)
mean(home$yds)
mean(away$yds)
  
ttest_pa <- t.test(away$pa, home$pa)
ttest_opp_yds <- t.test(away$opp_yds, home$opp_yds)

install.packages("flextable")
install.packages("rempsyc")
library(ggplot2)
library(dplyr)
library(broom)
library(flextable)
library(rempsyc)
home <- homeaway[homeaway$away == 0,]
away <- homeaway[homeaway$away == 1,]
t_result <- nice_t_test(data = homeaway, response = "result", group = "away", warning = FALSE, alternative = "greater", paired = TRUE)
t_result <- subset(t_result, select = -c(d))
t_pf <- nice_t_test(data = homeaway, response = "pf", group = "away", warning = FALSE, alternative = "greater", paired = TRUE)
t_pf <- subset(t_pf, select = -c(d))
t_pa <- nice_t_test(data = homeaway, response = "pa", group = "away", warning = FALSE, alternative = "less", paired = TRUE)
t_pa <- subset(t_pa, select = -c(d))
t_yds <- nice_t_test(data = homeaway, response = "yds", group = "away", warning = FALSE, alternative = "greater", paired = TRUE)
t_yds <- subset(t_yds, select = -c(d))
t_opp_yds <- nice_t_test(data = homeaway, response = "opp_yds", group = "away", warning = FALSE, alternative = "less", paired = TRUE)
t_opp_yds <- subset(t_opp_yds, select = -c(d))

t_df <- rbind(t_result, t_pf, t_pa, t_yds, t_opp_yds)
t_table <- nice_table(t_df, title = c("t-test Results for Home vs. Away Performance Metrics",""))
flextable::save_as_docx(t_table, path = "~/Downloads/t_table.docx")







#tables and graphs for fixed effects
#t-tests for home and away data
#anova





#within-subject data
  #include home-away variable
  #within= variable
  #home-away as co-variate and 
#do all models with different years
#try other types of regressions (esp. logistical for binary win/loss, chi-sq)
#cut years?
#cut COVID years?
#did homefield advantage change during COVID 2020?
  #do this year by year perhaps for five-year period
#try taking out controlling variables?