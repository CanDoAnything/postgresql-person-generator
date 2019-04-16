# postgresql-training

This repo is a demo of using postgreSQL with both powershell and maybe python.

## Prerequisites

### Required

- Connection to a PostgreSQL database
- Basic understanding of SQL

### Recommended

- VSCode
  - Plugins
    - markdownlint (David Anson)
    - Markdown Preview Enhanced (Yiyi Wang)
    - PostgreSQL (Chris Kolkman)

## Getting Started

### PowerShell

1. Open VSCode
2. Open the driver.ps1 file
3. Run it by pressing F5

### Python

1. [Install python](https://www.python.org/downloads/)
2. Install a package manager (pretty sure pip comes w/ python installer above by default)
3. Install the PostgreSQL database adapter: psycopg2 [(about)](http://initd.org/psycopg/docs/)
    1. Open a command prompt and run `pip install psycopg2`
4. d

## Architecture

### PowerShell

So far, it appears that there isn't a good way to connect to postgresql from powershell w/o usnig odbc. However, I imagine I should be able to import npgsql. Will explore

### Python

The files in the scripts/PowerShell folder

| File | Description |
| --- | --- |
| database_setup.ps1 | Runs the create database scripts |