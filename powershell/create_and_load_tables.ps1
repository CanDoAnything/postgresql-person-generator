# use pg driver

write-host $PSScriptRoot
$personGenInclude = $PSScriptRoot +"\person_generator.ps1"
."$personGenInclude"

generate -quantity 3
# load sql file 

# execute create database script

