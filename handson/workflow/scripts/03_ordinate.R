packages <- c("phyloseq", "vegan", "copiome",
              "dplyr", "stringr",
              "ggplot2", "cowplot", "ggthemes", "ggsci")

for (p in packages) {
  library(p, character.only = TRUE)
}

log <- file(snakemake@log$log_file, open = "wt")
sink(log) # comment this if running independently from snakemake

file_list <- list.files(snakemake@params$distance_folder, full.names = TRUE)

# Loading distances -------------------------------------------------------
taxon <- snakemake@params$taxon
threshold <- snakemake@params$threshold_prevalence
var <- snakemake@params$outcome

file_list.subset <- file_list %>%
  .[grepl(taxon, .)] %>%
  .[grepl(threshold, .)]

mds <- list() # empty list for storing the MDS plots

for (f in file_list.subset) {
  m <- str_replace(tail(unlist(str_split(f, "/")), 1), ".RData", "")
  print(paste0("Processing: ", m))
  midist <- head(unlist(str_split(tail(unlist(str_split(f, "/")), 1), "_")), 1)

  # load distance
  # rm(dist)
  load(f, verbose = TRUE)

  # ordinate
  MDS <- ordinate(physeq, "MDS", distance = dist)

  # permanova
  formula <- as.formula(paste0("dist ~ ", var))
  res.adonis <- adonis2(formula,
                        data = sample_df(physeq),
                        by = "margin")
  res.df <- data.frame(res.adonis) %>%
    mutate(parameter = rownames(.),
           distance = midist) %>%
    rename(pval = Pr..F.)

  # plot MDS
  p <- plot_ordination(physeq, MDS,
                       color = var,
                       axes = c(1, 2)) +
    theme_minimal() +
    labs(
      title = paste0(str_replace_all(m, "_", " "), " ", norm),
      subtitle = paste0("N samples: ", nsamples(physeq),
                        ", N taxa: ", ntaxa(physeq),
                        ", F: ", round(res.df$F, 2),
                        ", p-value: ",
                        format(subset(res.df, parameter == var)$pval,
                                             format = "e", digits = 1)),
      caption = paste0("dist ~ ", var)
    )
  mds[[m]] <- p
}

print("Plotting MDS PC1-2 for the different distances")
plot_grid(plotlist = mds)
ggsave(filename = snakemake@output$mds_fig,
       device = "png", dpi = 300,
       bg = "white", width = 13,
       height = 9)

print("Completed")