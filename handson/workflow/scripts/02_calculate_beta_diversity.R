packages <- c("phyloseq", "microbiome") 
for (p in packages) {
  library(p, character.only = TRUE)
}

log = file(snakemake@log$log_file, open = "wt")
sink(log)

# load data
print("Loading phyloeq object")
load(snakemake@input$phyloseq_file)
physeq

# Agglomerate to tax
taxon <- snakemake@params$taxon
if (taxon != "species") {
  print(paste0("Agglomerating to: ", taxon))
  physeq = tax_glom(physeq, taxon)
  physeq
} else {
  print("No agglomeration - Species taxon level")
}

# filter taxa by abundance
minTotRelAbun = snakemake@params$threshold_abundance
print(paste0("Filtering to ", minTotRelAbun, " abundance"))
x = taxa_sums(physeq)
keepTaxa = which((x / sum(x)) > minTotRelAbun)
physeq = prune_taxa(names(keepTaxa), physeq)
physeq

# transformation of data
print("Calculating distance...")
midistance <- snakemake@params$distance
if (midistance == "bray") {
  print(paste0("Distance: ", midistance))
  print("TSS normalisation")
  norm <- "TSS"
  physeq <- transform(physeq, transform="compositional")
  dist <- distance(physeq, method=midistance)
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance %in% c("jaccard", "unifrac")) {
  norm = ""
  dist <- distance(physeq, method=midistance)
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance == "euclidean") {
  print(paste0("Distance: ", midistance))
  print("Transforming counts to centered log ratio (CLR) using geometric means")
  norm <- "CLR"
  physeq <- transform(physeq, transform="clr") # CLR + euclidean = Aitchison distance (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5695134/)
  dist <- distance(physeq, method=midistance)
  save(dist, physeq, norm, file = snakemake@output$outfile)
} else if (midistance %in% c("jsd", "wunifrac")) {
  norm <- "Log10"
  print(paste0("Distance: ", midistance))
  print("Transforming counts to log10 + 1")
  physeq <- transform(physeq, transform="log10p")
  dist <- distance(physeq, method=midistance)
  if (midistance == "jsd") {
    dist <- sqrt(dist)
  }
  save(dist, physeq, norm, file = snakemake@output$outfile)
}

print("Completed")
