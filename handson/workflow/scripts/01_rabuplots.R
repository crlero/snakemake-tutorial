# Load required packages
packages <- c("phyloseq", "microbiome", "rabuplot",
              "copiome", "ggplot2")
if(!(require(rabuplot))) {
	remotes::install_github("jstokholm/rabuplot")
       install.packages("BiocManager")
	BiocManager::install("GenomeInfoDbData")
       library(rabuplot)
}
if(!(require(copiome))) {
  remotes::install_github("jonathanth/copiome@main")
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

log <- file(snakemake@log$log_file, open = "wt")
sink(log)

# Load phyloseq
print("Loading phyloseq object")
load(snakemake@input$phyloseq_file, verbose = TRUE)
physeq

# Summarise phyloseq
print("Summarise phyloseq object")
summarize_phyloseq(physeq)

# Relative abundance plots for delivery mode
print("Relative abundance plot for delivery mode")
p <- rabuplot(physeq, "cs_delivery")
ggsave(filename=snakemake@output$cs_fig,
       plot = p, device = "png", bg = "white")

# Relative abundance plots for asthma
print("Relative abundance plot for J45")
p <- rabuplot(physeq, "j45")
ggsave(filename=snakemake@output$j45_fig,
       plot = p, device = "png", bg="white")

# Relative abundance plots for wheeze
print("Relative abundance plot for JJJ")
p <- rabuplot(physeq, "jjj")
ggsave(filename=snakemake@output$jjj_fig, plot=p, device="png", bg="white")

# Relative abundance plots for atopic dermatitis
print("Relative abundance plot for AD")
p <- rabuplot(physeq, "ad")
ggsave(filename=snakemake@output$ad_fig, plot=p, device="png", bg="white")

print("Completed")