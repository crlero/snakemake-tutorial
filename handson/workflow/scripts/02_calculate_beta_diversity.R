packages <- c("phyloseq", "microbiome", "copiome")
for (p in packages) {
  library(p, character.only = TRUE)
}
if(!(require(copiome))) {
  remotes::install_github("jonathanth/copiome@main")
}

log <- file(snakemake@log$log_file, open = "wt")
sink(log)

# load data
print("Loading phyloeq object")
load(snakemake@input$phyloseq_file, verbose = TRUE)
physeq

# Agglomerate to tax
taxon <- snakemake@params$taxon
if (taxon != "Species") {
  print(paste0("Agglomerating to: ", taxon))
  physeq = tax_glom(physeq, taxon)
  physeq
} else {
  print("No agglomeration - Species taxon level")
}

# filter taxa by prevalence
physeq <- filter_phy(physeq,
                     prevalence = snakemake@params$threshold_prevalence)

# transformation of data
print("Calculating distance...")
midistance <- snakemake@params$distance
if (midistance == "bray") {
  print(paste0("Distance: ", midistance))
  norm <- "TSS"
  physeq <- transform_phy(physeq, transform = "compositional")
  dist <- distance(physeq, method = midistance)
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance %in% c("jaccard", "unifrac")) {
  print(paste0("Distance: ", midistance))
  norm = "PA"
  if (midistance == "jaccard") {
    dist <- distance(physeq, method = midistance,
                     binary = TRUE)
  } else {
    dist <- distance(physeq, method = midistance)
  }
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance == "euclidean") {
  print(paste0("Distance: ", midistance))
  norm <- "CLR"
  # CLR + euclidean = Aitchison distance (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5695134/)
  physeq <- transform_phy(physeq, transform = "clr")
  dist <- distance(physeq, method = midistance)
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance %in% c("jsd", "wunifrac")) {
  print(paste0("Distance: ", midistance))
  norm <- "Log10"
  physeq <- transform_phy(physeq, transform = "log")
  dist <- distance(physeq, method = midistance)
  if (midistance == "jsd") {
    dist <- sqrt(dist)
  }
  save(dist, physeq, norm, file = snakemake@output$outfile)
}

print("Completed")
