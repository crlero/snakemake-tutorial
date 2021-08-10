#!/bin/sh

# conda activate tutorial

# snakemake -n # dry-run
snakemake --cores # uses all cores available, otherwise specify the number after the param cores

# conda deactivate