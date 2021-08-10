# Snakemake tutorial

## Install miniconda3

If you don't have conda (miniconda, conda or Anaconda) yet, install [Miniconda3 MaxOSX 64-bit bash](https://docs.conda.io/en/latest/miniconda.html).

```bash
bash Miniconda3-latest-MacOSX-x86_64.sh
```

Follow the prompts on the installer screens and test the installation with:

```bash
conda list
```

## Download this repo

Then, download this repository to your favourite local computer. If you already have `git` installed, you can download it with:

```git
git clone https://github.com/crlero/snakemake-tutorial.git
# or
git clone git@github.com:crlero/snakemake-tutorial.git
```

... otherwise download the `ZIP` repository from the `Code` button on the up-right side of this page.

## Recreate this tutorial environment

In order to be able to run this workflow example, we must ensure we are running it within a defined environment. To do so, you can either create a new conda environment using the `yaml` file and download the specific dependencies defined in it or you can activate the environment from the zipped folder that I have placed in the NAS server to speed up the slow stuff :-).

### Create conda environment from the .yaml file

```bash
cd snakemake-tutorial/handson/
conda env create --name tutorial --file=workflow/environment.yaml
conda activate tutorial
```

### Activate folder with the environment

```bash
mkdir environment_tutorial
tar xzvf /Volumes/UserFolders/cristina.leal/snakemake-tutorial/environment_tutorial.tar.gz -C environment_tutorial
source environment_tutorial/bin/activate # activates the environment
source environment_tutorial/bin/deactivate # deactivates the environment
```
