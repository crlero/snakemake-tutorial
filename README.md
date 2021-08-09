# Snakemake tutorial

## Install miniconda3

```bash
bash Miniconda3-latest-MacOSX-x86_64.sh
```

Follow the prompts on the installer screens and test the installation with:

```bash
conda list
```

## Download this repo

```git
git clone git@github.com:crlero/snakemake-tutorial.git
```

... or download the `ZIP` repository.

## Recreate this tutorial environment

## Create conda environment from the .yaml file

```bash
cd snakemake-tutorial/handson/
conda env create -n tutorial --file workflow/environment.yaml
conda activate tutorial
```

## Unzip folder with the environment

```bash
mkdir environment_tutorial
tar xzvf /Volumes/UserFolders/cristina.leal/snakemake-tutorial/environment_tutorial.tar.gz -C environment_tutorial
source environment_tutorial/bin/activate # activate the environment
```
