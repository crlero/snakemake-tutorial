# Load required packages
packages <- c("phyloseq", "microbiome", "rabuplot", "ggplot2")
if(!(require(rabuplot))) {
	remotes::install_github("jstokholm/rabuplot")
}
for (p in packages) {
	library(p, character.only = TRUE)
}

# setClass("snakemake", slots = c(input = "list", params = "list", output = "list", log = "list"))
# snakemake <- new("snakemake",
#                  input = list(phyloseq_file = "~/Documents/workshops/snakemake/handson/data/test_set.RData"),
#                  output = list(cs_fig = "~/Documents/workshops/snakemake/handson/results/rabuplot_delivery.png",
#				 j45_fig = "~/Documents/workshops/snakemake/handson/results/rabuplot_j45.png",
#				 jjj_fig = "~/Documents/workshops/snakemake/handson/results/rabuplot_jjj.png",
#				 ad_fig = "~/Documents/workshops/snakemake/handson/results/rabuplot_ad.png"),
#                  log = list(log_file = "~/Documents/workshops/snakemake/handson/logs/rabuplots.log"))

log = file(snakemake@log$log_file, open = "wt")
sink(log)

# Load phyloseq
print("Loading phyloseq object")
load(snakemake@input$phyloseq_file)
physeq

# Summarise phyloseq
print("Summarise phyloseq object")
summarize_phyloseq(physeq)

# Relative abundance plots for delivery mode
print("Relative abundance plot for delivery mode")
rabuplot(physeq, "cs_delivery")
ggsave(snakemake@output$cs_fig, device="png", bg="white")

# Relative abundance plots for asthma
print("Relative abundance plot for J45")
rabuplot(physeq, "j45")
ggsave(snakemake@output$j45_fig, device="png", bg="white")

# Relative abundance plots for wheeze
print("Relative abundance plot for JJJ")
rabuplot(physeq, "jjj")
ggsave(snakemake@output$jjj_fig, device="png", bg="white")

# Relative abundance plots for atopic dermatitis
print("Relative abundance plot for AD")
rabuplot(physeq, "ad")
ggsave(snakemake@output$ad_fig, device="png", bg="white")

print("Completed")