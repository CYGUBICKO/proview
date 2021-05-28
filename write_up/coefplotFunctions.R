coefdf <- function(models) {
	#### Hsien et al. estimates
	coef_estimates_hsien <- (openxlsx::read.xlsx("coefficient_estimates_hsien.xlsx", sheet = "coefs2")
		%>% gather(Cohort, estimate, -term, -Category)
		%>% mutate(Study = "Hsien")
	)
	est <- purrr::map(models, broom::tidy, conf.int=TRUE)
	est <- (dplyr::bind_rows(est, .id="Cohort")
		%>% mutate(Study = "Comparison")
		%>% left_join(coef_estimates_hsien %>% select(term, Cohort, Category), by = c("term", "Cohort"))
		%>% mutate(term=gsub("\\(primary or secondary caregiver lives with pt\\)|\\(primary or secondary caregiver lives with pt\\)|\\(pt does not have caregiver\\)|: nursing and/or personal support|intestinal", "", term))
	)

	return(est)
}

coefplot <- function(coef_df, pos = 0.5, per_category=TRUE) {
	coef_plotFun <- function(df, pos){
		pos <- position_dodge(pos)
		coef_plot <- (ggplot(df, aes(y = estimate, x = reorder(term, estimate), colour=Cohort))
			+ geom_point(alpha = 0.5, position = pos)
			+ geom_pointrange(aes(ymin = conf.low, ymax = conf.high, colour=Cohort), position=pos)
			+ geom_hline(yintercept = 0, size = 0.5, lty = 2, colour = "grey")
			+ scale_colour_viridis_d(option="plasma")
			+ coord_flip()
		)
		return(coef_plot)
	}
	
	if (per_category) {
		categories <- unique(coef_df$Category)
		coef_plots_list <- lapply(categories, function(x){
			df <- coef_df %>% filter(Category==x) %>% droplevels() %>% mutate(term=reorder(term, estimate))
			p1 <- coef_plotFun(df, pos) + labs(x = "", y = "Estimate", title = x) #+ facet_grid(Cohort~.)
			return(p1)
		})

	} else {
		coef_plots_list <- coef_plotFun(coef_df, pos) + labs(x = "", y = "Estimate") + facet_wrap(~Category, scales="free")
	}
	return(coef_plots_list)
}

save(file = "coefplotFunctions.rda"
	, coefplot
	, coefdf
)
