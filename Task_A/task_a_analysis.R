# ============================================================================
# Task A: Statistical Analysis of Hotel Revenue and Associated Factors
# CIS6008 - Analytics and Business Intelligence
# Dataset: HOTELS_2025.csv (HotelQualityRank: 0, 1, 2)
# ============================================================================

rm(list = ls())

# Packages
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("corrplot")) install.packages("corrplot", dependencies = TRUE)
if (!require("car")) install.packages("car", dependencies = TRUE)
if (!require("lmtest")) install.packages("lmtest", dependencies = TRUE)
if (!require("nortest")) install.packages("nortest", dependencies = TRUE)
if (!require("e1071")) install.packages("e1071", dependencies = TRUE)

library(ggplot2)
library(corrplot)
library(car)
library(lmtest)
library(nortest)
library(e1071)

# Working directory
if (!file.exists("HOTELS_2025.csv") && file.exists("Task_A/HOTELS_2025.csv")) {
  setwd("Task_A")
}

# Output folder
dir.create("outputs", showWarnings = FALSE)
plot_dir <- "outputs"
pw <- 800
ph <- 600
pr <- 120

# ----------------------------------------------------------------------------
# 1. DATA LOADING AND INITIAL EXPLORATION
# ----------------------------------------------------------------------------
cat("\n", strrep("=", 70), "\n")
cat("1. DATA OVERVIEW AND INITIAL EXPLORATION\n")
cat(strrep("=", 70), "\n\n")

hotels <- read.csv("HOTELS_2025.csv")

cat("Dimensions:\n")
print(dim(hotels))

cat("\nFirst 6 rows:\n")
print(head(hotels))

cat("\nData structure:\n")
str(hotels)

cat("\nSummary statistics:\n")
print(summary(hotels))

cat("\nMissing values:\n")
print(colSums(is.na(hotels)))

cat("\nRevenue summary:\n")
cat("  Min:", min(hotels$Revenue), "| Mean:", round(mean(hotels$Revenue), 2),
    "| Max:", max(hotels$Revenue), "\n\n")

# Descriptive statistics (Mean, SD, Skewness, Kurtosis) - ALL numeric variables
num_vars <- c("RoomsAvailable", "OccupancyRate", "ADR", "MarketingSpend",
              "StaffCount", "Revenue", "HotelQualityRank",
              "GuestSatisfactionScore", "LoyaltyMembers")
desc <- data.frame(
  Variable = num_vars,
  N = sapply(num_vars, function(v) sum(!is.na(hotels[[v]]))),
  Mean = sapply(num_vars, function(v) round(mean(hotels[[v]], na.rm = TRUE), 3)),
  SD = sapply(num_vars, function(v) round(sd(hotels[[v]], na.rm = TRUE), 3)),
  Skewness = sapply(num_vars, function(v) round(e1071::skewness(hotels[[v]], na.rm = TRUE), 3)),
  Kurtosis = sapply(num_vars, function(v) round(e1071::kurtosis(hotels[[v]], na.rm = TRUE), 3))
)
cat("Descriptive statistics (Mean, SD, Skewness, Kurtosis):\n")
print(desc)
cat("\n")

# ----------------------------------------------------------------------------
# 2. NORMALITY TESTING AND DISTRIBUTION ANALYSIS
# ----------------------------------------------------------------------------
cat("\n", strrep("=", 70), "\n")
cat("2. NORMALITY TESTING AND DISTRIBUTION ANALYSIS\n")
cat(strrep("=", 70), "\n\n")

cat("Hypotheses:\n")
cat("  H0: Revenue follows a normal distribution\n")
cat("  H1: Revenue does NOT follow a normal distribution\n")
cat("  alpha = 0.05. Reject H0 if p-value < 0.05\n\n")

# Shapiro-Wilk for Revenue
sw <- shapiro.test(hotels$Revenue)
cat("Shapiro-Wilk test (Revenue):\n")
cat("  W =", round(sw$statistic, 4), ", p-value =", format(sw$p.value, digits = 4), "\n")
if (sw$p.value > 0.05) {
  cat("  Conclusion: Revenue appears normally distributed (p > 0.05)\n\n")
} else {
  cat("  Conclusion: Revenue does NOT follow normal distribution (p < 0.05)\n\n")
}

# Anderson-Darling for Revenue
ad <- ad.test(hotels$Revenue)
cat("Anderson-Darling test (Revenue):\n")
cat("  A =", round(ad$statistic, 4), ", p-value =", format(ad$p.value, digits = 4), "\n\n")

# Histogram
png(file.path(plot_dir, "01_hist_revenue.png"), width = pw, height = ph, res = pr)
hist(hotels$Revenue, main = "Distribution of Hotel Revenue",
     xlab = "Revenue", col = "skyblue", breaks = 30)
dev.off()

# Histogram with normal curve
png(file.path(plot_dir, "02_hist_normal_curve.png"), width = pw, height = ph, res = pr)
hist(hotels$Revenue, probability = TRUE, main = "Revenue with Normal Curve",
     xlab = "Revenue", col = "lightblue", breaks = 30)
curve(dnorm(x, mean(hotels$Revenue), sd(hotels$Revenue)), add = TRUE, col = "red", lwd = 2)
dev.off()

# Q-Q plot
png(file.path(plot_dir, "03_qqplot_revenue.png"), width = pw, height = ph, res = pr)
qqnorm(hotels$Revenue, main = "Q-Q Plot for Revenue")
qqline(hotels$Revenue, col = "red")
dev.off()

# ----------------------------------------------------------------------------
# 3. CORRELATION ANALYSIS
# ----------------------------------------------------------------------------
cat("\n", strrep("=", 70), "\n")
cat("3. CORRELATION ANALYSIS\n")
cat(strrep("=", 70), "\n\n")

cat("Hypotheses (Pearson):\n")
cat("  H0: No significant linear correlation (r = 0)\n")
cat("  H1: Significant correlation exists (r != 0)\n")
cat("  alpha = 0.05. Reject H0 if p-value < 0.05\n\n")

num_cols <- c("RoomsAvailable", "OccupancyRate", "ADR", "MarketingSpend",
              "StaffCount", "GuestSatisfactionScore", "LoyaltyMembers",
              "HotelQualityRank", "Revenue")
num_data <- hotels[, num_cols]

cor_m <- cor(num_data, use = "complete.obs")
cat("Correlation matrix:\n")
print(round(cor_m, 3))

# Correlations with Revenue (r and p-value)
pred_cols <- setdiff(num_cols, "Revenue")
cat("\nCorrelation with Revenue (r, p-value, significance):\n")
cat(sprintf("  %-22s  %8s  %12s  %5s\n", "Variable", "r", "p-value", "Sig"))
cat(" ", strrep("-", 52), "\n")
for (v in pred_cols) {
  tc <- cor.test(hotels[[v]], hotels$Revenue)
  r <- round(tc$estimate, 4)
  p <- tc$p.value
  sig <- ifelse(p < 0.001, "***", ifelse(p < 0.01, "**", ifelse(p < 0.05, "*", "ns")))
  cat(sprintf("  %-22s  %8.4f  %12.4e  %5s\n", v, r, p, sig))
}
cat(" ", strrep("-", 52), "\n")
cat("  *** p<0.001  ** p<0.01  * p<0.05  ns=not significant\n\n")

rev_cor <- cor(num_data[, -9], num_data$Revenue)
rev_cor_vec <- setNames(as.numeric(rev_cor), colnames(num_data)[-9])
cat("Correlation with Revenue (sorted by |r|):\n")
print(sort(abs(rev_cor_vec), decreasing = TRUE))

# Spearman (non-parametric) correlation with Revenue
cat("\nSpearman correlation with Revenue:\n")
cat(sprintf("  %-22s  %8s  %12s  %5s\n", "Variable", "rho", "p-value", "Sig"))
cat(" ", strrep("-", 52), "\n")
for (v in pred_cols) {
  sp <- cor.test(hotels[[v]], hotels$Revenue, method = "spearman", exact = FALSE)
  sig <- ifelse(sp$p.value < 0.001, "***", ifelse(sp$p.value < 0.01, "**", ifelse(sp$p.value < 0.05, "*", "ns")))
  cat(sprintf("  %-22s  %8.4f  %12.4e  %5s\n", v, sp$estimate, sp$p.value, sig))
}
cat(" ", strrep("-", 52), "\n\n")

# Heatmap
png(file.path(plot_dir, "04_correlation_matrix.png"), width = 900, height = 700, res = pr)
corrplot(cor_m, method = "color", type = "upper", addCoef.col = "black",
         number.cex = 0.7, tl.srt = 45, mar = c(0, 0, 2, 0),
         title = "Correlation Matrix - Hotel Variables")
dev.off()

# Bar chart: Correlation with Revenue
cor_df <- data.frame(Variable = names(rev_cor_vec), r = as.numeric(rev_cor_vec))
cor_df <- cor_df[order(cor_df$r), ]
cor_df$Variable <- factor(cor_df$Variable, levels = cor_df$Variable)
p_bar <- ggplot(cor_df, aes(x = Variable, y = r, fill = ifelse(r > 0, "Positive", "Negative"))) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_hline(yintercept = 0, colour = "black") +
  geom_text(aes(label = round(r, 3)), hjust = ifelse(cor_df$r >= 0, -0.1, 1.1), size = 3) +
  scale_fill_manual(values = c("Positive" = "#2ecc71", "Negative" = "#e74c3c")) +
  coord_flip() + labs(title = "Pearson Correlation with Revenue", x = "Variable", y = "r") +
  theme_bw()
ggsave(file.path(plot_dir, "04b_correlation_bar.png"), p_bar, width = 8, height = 6, dpi = 120)

# ----------------------------------------------------------------------------
# 4. REGRESSION ANALYSIS
# ----------------------------------------------------------------------------
cat("\n", strrep("=", 70), "\n")
cat("4. REGRESSION ANALYSIS\n")
cat(strrep("=", 70), "\n\n")

# --- 4.1 Simple Linear Regression (ALL predictors) ---
cat("4.1 Simple Linear Regression (all predictors)\n")
cat("Hypotheses (each SLR): H0: beta1=0 (no effect). H1: beta1!=0 (significant effect). alpha=0.05\n")
cat(strrep("-", 50), "\n")

preds <- pred_cols
slr_list <- list()

# SLR summary table
cat("\nSLR Summary Table:\n")
cat(sprintf("  %-22s  %8s  %8s  %10s  %5s\n", "Predictor", "R2", "Adj.R2", "p-value", "Sig"))
cat(" ", strrep("-", 60), "\n")
for (p in preds) {
  m <- lm(as.formula(paste("Revenue ~", p)), data = hotels)
  slr_list[[p]] <- m
  s <- summary(m)
  pval <- pf(s$fstatistic[1], s$fstatistic[2], s$fstatistic[3], lower.tail = FALSE)
  sig <- ifelse(pval < 0.001, "***", ifelse(pval < 0.01, "**", ifelse(pval < 0.05, "*", "ns")))
  cat(sprintf("  %-22s  %8.4f  %8.4f  %10.4e  %5s\n", p, s$r.squared, s$adj.r.squared, pval, sig))
}
cat(" ", strrep("-", 60), "\n\n")

# Top 3 detailed (by |r|)
top3 <- names(sort(abs(rev_cor_vec), decreasing = TRUE))[1:3]
cat("Top 3 predictors - Detailed SLR:\n")
for (p in top3) {
  m <- slr_list[[p]]
  s <- summary(m)
  pval <- pf(s$fstatistic[1], s$fstatistic[2], s$fstatistic[3], lower.tail = FALSE)
  cat(strrep("=", 50), "\nRevenue ~", p, "\n")
  cat("H0: beta1=0 | H1: beta1!=0 | Decision:", ifelse(pval < 0.05, "Reject H0", "Fail to reject H0"), "\n\n")
  print(s)
  cat("Equation: Revenue =", round(coef(m)[1], 2), "+", round(coef(m)[2], 4), "*", p, "\n\n")
}

# SLR diagnostic plots (top predictor)
png(file.path(plot_dir, "05a_slr_diagnostics.png"), width = 900, height = 700, res = pr)
par(mfrow = c(2, 2))
plot(slr_list[[top3[1]]], main = paste("SLR Diagnostics: Revenue ~", top3[1]))
par(mfrow = c(1, 1))
dev.off()

# Scatter plots with r value in subtitle
scatter_with_r <- function(p) {
  r <- round(cor(hotels[[p]], hotels$Revenue), 4)
  pv <- cor.test(hotels[[p]], hotels$Revenue)$p.value
  sig <- ifelse(pv < 0.001, "p<0.001", ifelse(pv < 0.01, "p<0.01", ifelse(pv < 0.05, "p<0.05", "ns")))
  plot(hotels[[p]], hotels$Revenue, xlab = p, ylab = "Revenue",
       main = paste("Revenue vs", p), sub = paste0("r = ", r, ", ", sig),
       pch = 19, col = rgb(0, 0, 1, 0.4))
  abline(slr_list[[p]], col = "red", lwd = 2)
}

png(file.path(plot_dir, "05_scatter_slr_1.png"), width = pw, height = ph, res = pr)
par(mfrow = c(2, 2))
for (p in preds[1:4]) scatter_with_r(p)
par(mfrow = c(1, 1))
dev.off()

png(file.path(plot_dir, "05_scatter_slr_2.png"), width = pw, height = ph, res = pr)
par(mfrow = c(2, 2))
for (p in preds[5:8]) scatter_with_r(p)
par(mfrow = c(1, 1))
dev.off()

# --- 4.2 Multiple Linear Regression ---
cat("\n\n4.2 Multiple Linear Regression (Full Model)\n")
cat("Hypotheses: H0: all betas=0. H1: at least one beta!=0. Per coef: H0_i: betai=0.\n")
cat(strrep("-", 50), "\n")

model_full <- lm(Revenue ~ RoomsAvailable + OccupancyRate + ADR + MarketingSpend +
                   StaffCount + GuestSatisfactionScore + LoyaltyMembers + HotelQualityRank,
                 data = hotels)
print(summary(model_full))

# VIF
cat("\nVIF (Multicollinearity check):\n")
vif_full <- vif(model_full)
print(round(vif_full, 3))

# Variable selection: keep predictors with p < 0.05
coef_p <- summary(model_full)$coefficients[-1, 4]
keep <- names(coef_p)[coef_p < 0.05]
if (length(keep) == 0) {
  keep <- c("RoomsAvailable", "OccupancyRate", "ADR", "StaffCount", "LoyaltyMembers")
}

# Reduced model
fmla <- as.formula(paste("Revenue ~", paste(keep, collapse = " + ")))
model_red <- lm(fmla, data = hotels)

# Model comparison (Full vs Reduced) - ANOVA
cat("\nModel comparison (ANOVA: Full vs Reduced):\n")
cat("  H0: Removed predictors do not improve fit. If p > 0.05, Reduced preferred.\n")
print(anova(model_red, model_full))
cat("\n")

cat("4.2 Reduced Model (significant predictors only):\n")
cat(strrep("-", 50), "\n")
print(summary(model_red))

# Regression equation
cf <- coef(model_red)
cat("\nRegression equation:\n")
cat("  Revenue =", round(cf[1], 2))
for (i in 2:length(cf)) {
  cat(" +", round(cf[i], 4), "*", names(cf)[i])
}
cat("\n\n")

# Model diagnostics (4-panel plot)
png(file.path(plot_dir, "06_model_diagnostics.png"), width = 900, height = 700, res = pr)
par(mfrow = c(2, 2))
plot(model_red, which = 1:4)
par(mfrow = c(1, 1))
dev.off()

# Breusch-Pagan (homoscedasticity)
cat("Breusch-Pagan test (homoscedasticity):\n")
cat("  H0: Constant variance (homoscedastic). H1: Non-constant variance.\n")
bp <- bptest(model_red)
print(bp)
cat("  If p > 0.05: Fail to reject H0 (homoscedasticity assumed).\n\n")

# Durbin-Watson (autocorrelation)
cat("Durbin-Watson test (autocorrelation):\n")
cat("  H0: No autocorrelation (DW near 2). H1: Autocorrelation present.\n")
dw <- dwtest(model_red)
print(dw)
cat("  If p > 0.05: Fail to reject H0 (no autocorrelation).\n\n")

# VIF for reduced model
cat("VIF (Reduced model):\n")
print(round(vif(model_red), 3))

# Residuals normality (H0/H1)
cat("\nResiduals normality (Shapiro-Wilk):\n")
cat("  H0: Residuals are normally distributed. H1: Not normal.\n")
sw_res <- shapiro.test(residuals(model_red))
print(sw_res)
cat("  Decision:", ifelse(sw_res$p.value > 0.05, "Fail to reject H0", "Reject H0"), "\n\n")

# Model comparison table (R2, AIC, BIC)
cat("Model comparison table:\n")
cat(sprintf("  %-28s  %8s  %9s  %10s  %10s\n", "Model", "R2", "Adj.R2", "AIC", "BIC"))
cat(" ", strrep("-", 70), "\n")
for (lb in c("SLR (top)", "MLR Full", "MLR Reduced")) {
  mod <- if (lb == "SLR (top)") slr_list[[top3[1]]] else if (lb == "MLR Full") model_full else model_red
  sm <- summary(mod)
  cat(sprintf("  %-28s  %8.4f  %9.4f  %10.1f  %10.1f\n", lb, sm$r.squared, sm$adj.r.squared, AIC(mod), BIC(mod)))
}
cat(" ", strrep("-", 70), "\n")
cat("  Lower AIC/BIC = better fit\n\n")

# Actual vs Predicted
hotels$predicted <- fitted(model_red)
png(file.path(plot_dir, "07_actual_vs_predicted.png"), width = pw, height = ph, res = pr)
plot(hotels$Revenue, hotels$predicted, xlab = "Actual Revenue", ylab = "Predicted Revenue",
     main = "Actual vs Predicted Revenue", pch = 19, col = rgb(0, 0, 1, 0.4))
abline(0, 1, col = "red", lwd = 2)
dev.off()

# ----------------------------------------------------------------------------
# 5. QUALITY RANK COMPARISON (Revenue by HotelQualityRank)
# ----------------------------------------------------------------------------
cat("\n", strrep("=", 70), "\n")
cat("5. REVENUE BY HOTEL QUALITY RANK (0, 1, 2)\n")
cat(strrep("=", 70), "\n\n")

# One-way ANOVA: H0 = mean Revenue same across groups
aov_rank <- aov(Revenue ~ factor(HotelQualityRank), data = hotels)
cat("One-way ANOVA (Revenue by HotelQualityRank):\n")
cat("  H0: Mean revenue same across groups 0, 1, 2. H1: At least one group mean differs.\n")
cat("  alpha = 0.05. Reject H0 if p < 0.05.\n")
print(summary(aov_rank))
cat("\n")

# Means by group
cat("Mean Revenue by Quality Rank:\n")
print(aggregate(Revenue ~ HotelQualityRank, data = hotels, FUN = mean))

png(file.path(plot_dir, "08_revenue_by_quality.png"), width = pw, height = ph, res = pr)
boxplot(Revenue ~ factor(HotelQualityRank), data = hotels,
        main = "Revenue by Hotel Quality Rank", xlab = "Hotel Quality Rank",
        ylab = "Revenue", col = c("lightcoral", "lightyellow", "lightgreen"))
dev.off()

# ----------------------------------------------------------------------------
# 6. SAVE RESULTS
# ----------------------------------------------------------------------------
write.csv(hotels, "Hotels_With_Predictions.csv", row.names = FALSE)

sink("Task_A_Model_Results.txt")
cat("FULL MODEL\n"); print(summary(model_full))
cat("\nREDUCED MODEL\n"); print(summary(model_red))
cat("\nANOVA (Full vs Reduced)\n"); print(anova(model_red, model_full))
cat("\nVIF\n"); print(vif(model_red))
cat("\nBreusch-Pagan\n"); print(bp)
cat("\nDurbin-Watson\n"); print(dw)
cat("\nResiduals Normality\n"); print(sw_res)
cat("\nANOVA (Revenue by Quality Rank)\n"); print(summary(aov_rank))
sink()

cat("\n\nAnalysis complete. Plots saved in:", plot_dir, "\n")
