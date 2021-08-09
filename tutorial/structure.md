# Distribution and reproducibility

Each workflow should be structured as following:

```tree
my_project
├── .gitignore
├── README.md
├── config
│   ├── config.yaml
├── workflow
│   ├── envs
|   │   ├── environment.yaml
│   ├── benchmarks
│   ├── scripts
|   │   ├── script1.py
|   │   └── script2.R
│   ├── notebooks
|   │   ├── notebook1.py.ipynb
|   │   └── notebook2.r.ipynb
│   ├── report
|   │   ├── report.html
|   └── Snakefile
├── results
├── logs
└── resources
```

Read more: <https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html>
