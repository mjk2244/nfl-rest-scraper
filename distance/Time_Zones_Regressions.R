distance <- read.csv(file.choose())
#file: distance_all.csv

fit_yds <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_yds)
fit_yds2 <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct + week, data=distance)
summary(fit_yds2)
#not significant!

fit_opp_yds <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_opp_yds)
#coefficient on time_zone_diff = -1.849

fit_pf <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_pf)
#not significant!

fit_pa <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_pa)
#not significant!

fit_result <- lm(result ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_result)
#not significant!

#logit regression -> not significant!
logit_result <- glm(result ~ time_zone_diff + win_pct + opp_win_pct, data=distance, family="binomial")
summary(logit_result)

#probit regression -> not significant!
probit_result <- glm(result ~ time_zone_diff + win_pct + opp_win_pct, data=distance, family="binomial"(link = "probit"))
summary(probit_result)

ydsa <- lm(yds ~ time_zone_diff, data=distance)
summary(ydsa)
ydsb <- lm(yds ~ time_zone_diff + win_pct, data=distance)
summary(ydsb)
ydsc <- lm(yds ~ time_zone_diff + opp_win_pct, data=distance)
summary(ydsc)

#all three significant!!!
opp_ydsa <- lm(opp_yds ~ time_zone_diff, data=distance)
summary(opp_ydsa)
opp_ydsb <- lm(opp_yds ~ time_zone_diff + win_pct, data=distance)
summary(opp_ydsb)
opp_ydsc <- lm(opp_yds ~ time_zone_diff + opp_win_pct, data=distance)
summary(opp_ydsc)

pfa <- lm(pf ~ time_zone_diff, data=distance)
summary(pfa)
pfb <- lm(pf ~ time_zone_diff + win_pct, data=distance)
summary(pfb)
pfc <- lm(pf ~ time_zone_diff + opp_win_pct, data=distance)
summary(pfc)

paa <- lm(pa ~ time_zone_diff, data=distance)
summary(paa)
pab <- lm(pa ~ time_zone_diff + win_pct, data=distance)
summary(pab)
pac <- lm(pa ~ time_zone_diff + opp_win_pct, data=distance)
summary(pac)

resulta <- lm(result ~ time_zone_diff, data=distance)
summary(resulta)
resultb <- lm(result ~ time_zone_diff + win_pct, data=distance)
summary(resultb)
resultc <- lm(result ~ time_zone_diff + opp_win_pct, data=distance)
summary(resultc)

distance
distance_new <- distance[ , unlist(lapply(distance, is.numeric))]
distance_new
distance_scaled <- scale(distance_new)
distance_scaled <- as.data.frame(distance_scaled)
opp_yds_std <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data = distance_scaled)
summary(opp_yds_std)
std_coef <- coef(opp_yds_std) / sd(distance_scaled$opp_yds)
summary(std_coef)

sd(distance$opp_yds)
fit_opp_yds <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
summary(fit_opp_yds)

library(stargazer)
fit_result <- lm(result ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
logit_result <- glm(result ~ time_zone_diff + win_pct + opp_win_pct, data=distance, family="binomial")
fit_pf <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
fit_pa <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
fit_yds <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
fit_opp_yds <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=distance)
stargazer(fit_result, logit_result, fit_pf, fit_pa, fit_yds, fit_opp_yds,
          title = "Table 4: Time Zone Difference (Δ in UTC) Regression Model Output",
          title.center = TRUE,
          align = TRUE,
          type = "text")

install.packages("ggplot2")
install.packages("ggpubr")
library(ggpubr)
ggscatter(distance, x = "time_zone_diff", y = "opp_yds", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          covariates = c("win_pct", "opp_win_pct")) +
  xlab("Time Zone Difference (Δ in UTC)") +
  ylab("Yards Allowed to Opponent") +
  ggtitle("Figure 2: Time Zone Difference vs. Yards Allowed")
  #theme(plot.title = element_text(hjust = 0.5, vjust = 0.5)

#library(htmlwidgets)
#library(webshot)
#install_phantomjs()
#opp_yds_table <- stargazer(fit_opp_yds, type = "html")
#webshot("opp_yds_table.html", "opp_yds_table.jpg")
#opp_yds_table <- image_read("opp_yds_table.jpg")
#saveWidget(opp_yds_table, "opp_yds_table.html")
  
#install.packages("magick")
#library(magick)
#opp_yds_table <- image_read("opp_yds_table.pdf")
#image_write(opp_yds_table, path = "opp_yds_table.jpg")

#install.packages("htmlwidgets")
#install.packages("webshot")
#library(htmlwidgets)
#library(webshot)
#opp_yds_table <- stargazer(fit_opp_yds, type = "html")
#saveWidget(opp_yds_table, "opp_yds_table.html")
#webshot("opp_yds_table.html", "opp_yds_table.jpg")

data(distance)
anova_result <- aov(result ~ time_zone_diff + win_pct + opp_win_pct, data = distance)
summary(anova_result)
anova_pf <- aov(pf ~ time_zone_diff + win_pct + opp_win_pct, data = distance)
summary(anova_pf)
anova_pa <- aov(pa ~ time_zone_diff + win_pct + opp_win_pct, data = distance)
summary(anova_pa)
anova_yds <- aov(yds ~ time_zone_diff + win_pct + opp_win_pct, data = distance)
summary(anova_yds)
anova_opp_yds <- aov(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data = distance)
summary(anova_opp_yds)

install.packages("plm")
library(plm)
distance_fixed <- plm.data(distance, index=c("team","year"))
result_fixed <- lm(result ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(result_fixed)
pf_fixed <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(pf_fixed) #significant at p < 0.1
pa_fixed <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(pa_fixed) #significant at p < 0.05
yds_fixed <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(yds_fixed)
opp_yds_fixed <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data = distance)
summary(opp_yds_fixed) #significant always!

homeaway <- read.csv(file.choose())
away <- homeaway[homeaway$away == 1,]
away_result <- lm(result ~ time_zone_diff + win_pct + opp_win_pct, data=away)
summary(away_result)
logit_away_result <- glm(result ~ time_zone_diff + win_pct + opp_win_pct, data=away, family="binomial")
summary(logit_away_result)
away_pf <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct, data=away)
summary(away_pf)
away_pa <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct, data=away)
summary(away_pa)
away_pa <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct, data=away)
summary(away_pa)
away_opp_yds <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=away)
summary(away_opp_yds) #significant p = 0.00688

library(plm)
away_fixed <- plm.data(away, index=c("team","year"))
away_result_fixed <- lm(result ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_result_fixed)
logit_away_result_fixed <- glm(result ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed, family="binomial")
summary(logit_away_result_fixed)
away_pf_fixed <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pf_fixed) #significant p = 0.07
away_pa_fixed <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pa_fixed) #significant p = 0.014
away_pa_fixed <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_pa_fixed)
away_opp_yds_fixed <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct + factor(team) + factor(year) - 1, data=away_fixed)
summary(away_opp_yds_fixed) #significant p = 0.000973

home <- homeaway[homeaway$away == 0,]
home_result <- lm(result ~ time_zone_diff + win_pct + opp_win_pct, data=home)
summary(home_result)
logit_home_result <- glm(result ~ time_zone_diff + win_pct + opp_win_pct, data=home, family="binomial")
summary(logit_home_result)
home_pf <- lm(pf ~ time_zone_diff + win_pct + opp_win_pct, data=home)
summary(home_pf)
home_pa <- lm(pa ~ time_zone_diff + win_pct + opp_win_pct, data=home)
summary(home_pa)
home_pa <- lm(yds ~ time_zone_diff + win_pct + opp_win_pct, data=home)
summary(home_pa)
home_opp_yds <- lm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct, data=home)
summary(home_opp_yds)

install.packages("lfe")
library(lfe)
#model <- felm(y ~ x1 + x2 | id, data = data)
away_result_felm <- felm(result ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=away)
summary(away_result_felm)
away_pf_felm <- felm(pf ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=away)
summary(away_pf_felm) #significant p = 0.0714
away_pa_felm <- felm(pa ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=away)
summary(away_pa_felm) #significant p = 0.0142
away_yds_felm <- felm(yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=away)
summary(away_yds_felm)
away_opp_yds_felm <- felm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=away)
summary(away_opp_yds_felm) #significant p = 0.000973
#away$result_logit <- log(away$result / (1 - away$result))
#logit_away_result_felm <- felm(result_logit ~ distance + win_pct + opp_win_pct | team + year , data=away)
#summary(logit_away_result_felm)
#Error in quantile.default(x$residuals) : 
#missing values and NaN's not allowed if 'na.rm' is FALSE
#In addition: Warning message:
#In summary.felm(logit_away_result_felm) : can't compute cluster F-test

home_result_felm <- felm(result ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=home)
summary(home_result_felm)
home_pf_felm <- felm(pf ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=home)
summary(home_pf_felm)
home_pa_felm <- felm(pa ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=home)
summary(home_pa_felm)
home_yds_felm <- felm(yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=home)
summary(home_yds_felm)
home_opp_yds_felm <- felm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=home)
summary(home_opp_yds_felm)

library(stargazer)
result_felm <- felm(result ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
summary(result_felm)
pf_felm <- felm(pf ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
summary(pf_felm)
pa_felm <- felm(pa ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
summary(pa_felm)
yds_felm <- felm(yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
summary(yds_felm)
opp_yds_felm <- felm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
summary(opp_yds_felm)
stargazer(result_felm, pf_felm, pa_felm, yds_felm, opp_yds_felm,
          title = "Time Zone Difference (Δ in UTC) Fixed Effects Regression Model Output",
          #title = "Table X: Time Zone Difference (Δ in UTC) Fixed Effects Regression Model Output",
          #title.center = TRUE,
          align = TRUE,
          type = "text")

sd(distance$pa)

library(ggplot2)
library(lfe)
pa_felm <- felm(pa ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
coef_data <- data.frame(variable = row.names(summary(pa_felm)$coef),
                        coef = summary(pa_felm)$coef[, 1],
                        se = summary(pa_felm)$coef[, 2])
coef_data$variable <- factor(coef_data$variable, levels = c("time_zone_diff", "win_pct", "opp_win_pct"))
ggplot(coef_data, aes(x = variable, y = coef, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = coef - 1.96 * se, ymax = coef + 1.96 * se),
                width = 0.2, position = position_dodge(width = 1)) +
  labs(x = "Variable", y = "Δ in Points Allowed per 1-Unit Change in IV", fill = NULL) +
  ggtitle("Time Zone Difference vs Points Allowed Regression Coefficients") +
  theme(plot.title = element_text(size = 14, face = "bold")) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x = element_text(size=16)) +
  theme(axis.title.y = element_text(size=16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(axis.text = element_text(size = 12))

opp_yds_felm <- felm(opp_yds ~ time_zone_diff + win_pct + opp_win_pct | team + year, data=distance)
coef_data2 <- data.frame(variable = row.names(summary(opp_yds_felm)$coef),
                        coef = summary(opp_yds_felm)$coef[, 1],
                        se = summary(opp_yds_felm)$coef[, 2])
coef_data2$variable <- factor(coef_data2$variable, levels = c("time_zone_diff", "win_pct", "opp_win_pct"))
ggplot(coef_data2, aes(x = variable, y = coef, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = coef - 1.96 * se, ymax = coef + 1.96 * se),
                width = 0.2, position = position_dodge(width = 1)) +
  labs(x = "Variable", y = "Δ in Yards Allowed per 1-Unit Change in IV", fill = NULL) +
  ggtitle("Time Zone Difference vs Yards Allowed Regression Coefficients") +
  theme(plot.title = element_text(size = 14, face = "bold")) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x = element_text(size=16)) +
  theme(axis.title.y = element_text(size=16)) +
  theme(legend.text = element_text(size = 12)) +
  theme(axis.text = element_text(size = 12))

#library(ggplot2)
#df <- data.frame(time_zone_diff = distance$time_zone_diff,
#                 resin = residuals(opp_yds_felm))
#means <- aggregate(resin ~ time_zone_diff, data = df, mean)
#ggplot(data = means, aes(x = time_zone_diff, y = residuals)) +
#  geom_bar(stat = "identity", fill = "blue") +
#  geom_errorbar(aes(ymin = residuals - sd(residuals), ymax = residuals + sd(residuals)), 
#                width = 0.2, color = "black") +
#  xlab("Time Zone Difference") +
#  ylab("Residuals") +
#  ggtitle("Mean Residuals by Time Zone Difference")

t.test(away$result, home$result)
t.test(away$pf, home$pf)
t.test(away$pa, home$pa)
t.test(away$yds, home$yds)
t.test(away$opp_yds, home$opp_yds)




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
#run ANOVA to compare 0 to 3 time zones
#run models within-subject