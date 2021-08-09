# Distribution and reproducibility

Each workflow should be structured as following:

my_project
├── .gitignore
├── README.md
├── workflow
│   ├── envs
|   │   ├── environment.yaml
│   ├── scripts
|   │   ├── script1.py
|   │   └── script2.R
│   ├── notebooks
|   │   ├── notebook1.py.ipynb
|   │   └── notebook2.r.ipynb
│   ├── report
|   │   ├── report.rst
|   └── Snakefile
├── config
│   ├── config.yaml
├── results
└── resources
  
Read more: <https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html>
