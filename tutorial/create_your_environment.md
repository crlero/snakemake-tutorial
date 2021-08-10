# Create your project environment

## Set up your conda channels

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

## Create a new environment

```bash
conda create -n tutorial -c conda-forge mamba
conda activate tutorial
```

### Installing needed packages and dependencies

#### From conda (recommended)

```bash
conda install snakemake 
conda install r-essentials
conda install bioconductor-microbiome
conda install bioconductor-phyloseq
conda install bioconductor-metagenomeseq
conda install r-vegan
conda install r-cowplot
conda install r-ggthemes
conda install r-ggsci
```

#### From R (not recommended, and if so add a rule to your workflow to download the packages)

```R
$ R 
>> if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

>> BiocManager::install("phyloseq")
>> BiocManager::install("microbiome")
>> install.packages("vegan")
```

## Testing and scripting using RStudio with your environment

Open a `tmux`screen, activate your environment and launch your RStudio. Now you are all set up for start writing testing your own code.

```bash
tmux new-session -s rstudio
conda activate tutorial
/Applications/RStudio.app/Contents/MacOS/RStudio
```

## Export your environment

Congratulations you have finished your manuscript (whoop-whoop!) and now you want to publish your data analysis code. So, you need to include your environment to make it fully reproducible.
Create a `yaml` file with your working conda environment.

```bash
conda env export -n tutorial > workflow/environment.yml # from outside environment
conda env export > workflow/environment.yml # from inside environment
```

... or you can also `ZIP` it into a folder (although this might be too heavy).

```bash
conda install conda-pack
conda-pack --name tutorial --output environment_tutorial.tar.gz
```
