# Spark - Project Codebase

## Overview

Default Project Codebase for `Spark` Deployment. Code structure, usage and documentation will be explained in [Project Structure](#project-structure) section. Deployment methods and architecture will be explained in [Deployment](#deployment) section. 

## Project Structure

This project codebase consist of two major parts:
- [Project](#project): Spark code project, consist of `Spark` definition and code dependencies.
- [Services](#services): Spark environment deployment code.

### Project

```sh
project                     # Project Root
├── jobs                    # Directory for jobs defintion
│   └── job_name*           # Single job code
│       ├── __init__.py
│       ├── functions.py    # Utility or logic function
│       └── main.py         # Argument parser and main runtime
├── sample                  # Sample data (for UAT)
├── shared                  # Shared modules / functions
└── runner.py               # Runner interface (interface for `spark-submit`)
```

**How to develop**

- Add new directory in `jobs` (create new `job_name`)
- Create general workflow and argument parser logic in `main.py` as placeholder functions
- Define placeholder functions in `main.py` script in `functions.py`


### Services
```sh
services                    # Services Root
├── spark                   # Spark services configuration
│   ├── Dockerfile          # Image definition for Spark
│   ├── spark-defaults.conf # Default config for Spark deployment
│   ├── startup.sh          # Entrypoint script for Spark deployment
│   └── submit_job.sh       # Script to submit job to Spark instance
├── command.sh              # Script notes for Spark standalone single machine
└── docker-compose.yml      # Compose config for Spark
```


## Deployment

This repo contains several ways of [`Spark` environment deployment]:
- [Standalone](#standalone)
- [Cluster](#cluster)

With additional enablement for [`Jupyter Notebook`](#additional-jupyter-notebook) guide.

<br>

**Notes**

all deployment can be used in local environment with prerequisites `Docker` (enable `Kubernetes` for Cluster mode). 

[How to enable Kubernetes with Docker Desktop]().

<br>

### Standalone

### Cluster

### (Additional) Jupyter Notebook