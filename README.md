# postgresql-person-generator

This demo application creates sets up and populates a postgresql database using various programming languages.

It loads the person table with random X number of random people with names from the census <https://www.census.gov/topics/population/genealogy/data/2010_surnames.html>.

## Architecture

The /data folder contains datasets used for random name generation. The /scripts folder has SQL and DDL.

The general flow of the application is as follows:

1. Creates person table (drops if exists)
2. Loads a few files into variables for sample data
3. Call the person generator and pass in the variables from the files
4. Insert the people into the person table

## Findings / Observations

Take a look at the [OBSERVATIONS.md] to see a table of the performance of the various languages/frameworks.

## Prerequisites

- Connection to a PostgreSQL database
- Basic understanding of SQL
- First name and last name list
  - I recommend downloading the three lists as csv at <https://www.census.gov/topics/population/genealogy/data/1990_census/1990_census_namefiles.html>
- VSCode
  - Plugins
    - markdownlint (David Anson)
    - Markdown Preview Enhanced (Yiyi Wang)
    - PostgreSQL (Chris Kolkman)

## Getting Started

### Python

1. [Install python](https://www.python.org/downloads/)
2. Install a package manager (pretty sure pip comes w/ python installer above by default)
3. Install the PostgreSQL database adapter: psycopg2 [(about)](http://initd.org/psycopg/docs/)
    1. Open a command prompt and run `pip install psycopg2`
4. d

### PowerShell

1. Open VSCode
2. Open the driver.ps1 file
3. Download and extract a few required DLLs from NuGet .nupkg files. (download, then rename the .nupkg to .zip and extract these files to the powershell folder)
    - Npgsql.dll [(link)](https://www.nuget.org/packages/Npgsql/)
    - System.Memory.dll [(link)](https://www.nuget.org/packages/System.Memory/)
    - System.Runtime.CompilerServices.Unsafe.dll [(link)](https://www.nuget.org/packages/System.Runtime.CompilerServices.Unsafe/)
    - System.Threading.Tasks.Extensions.dll [(link)](https://www.nuget.org/packages/System.Threading.Tasks.Extensions/)
4. Run it by pressing F5



### Python

The files in the scripts/PowerShell folder

| File | Description |
| --- | --- |
| database_setup.ps1 | Runs the create database scripts |

### PowerShell

So far, it appears that there isn't a good way to connect to postgresql from powershell w/o usnig odbc. However, I imagine I should be able to import npgsql. Will explore

