# Snakemake tutorial

## Install miniconda3

If you don't have conda (miniconda, conda or Anaconda) yet, install miniconda3.

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
source environment_tutorial/bin/activate # activates the environment
source environment_tutorial/bin/deactivate # deactivates the environment
```
