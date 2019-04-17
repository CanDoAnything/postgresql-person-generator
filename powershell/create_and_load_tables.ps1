# use pg driver


$secretsFilePath = $PSScriptRoot + "\..\secrets.json"
$personGenInclude = $PSScriptRoot + "\person_generator.ps1"
."$personGenInclude"

$secrets = Get-Content -Raw -Path $secretsFilePath | ConvertFrom-Json

$femaleNames = (Import-Csv ($PSScriptRoot + "\..\data\first_names_female.csv") -Header "Name").Name
$maleNames = (Import-Csv ($PSScriptRoot + "\..\data\first_names_male.csv") -Header "Name").Name
$lastNames = (Import-Csv ($PSScriptRoot + "\..\data\last_names.csv") -Header "Name").Name
$cityNames = (Import-Csv ($PSScriptRoot + "\..\data\city_names.csv") -Header "Name").Name
$stateCodes = (Import-Csv ($PSScriptRoot + "\..\data\state_codes.csv") -Header "Code").Code
$streetSuffixes = (Import-Csv ($PSScriptRoot + "\..\data\street_suffixes.csv") -Header "Suffix").Suffix

$ssnStart = 123456789
$ssnEnd = $ssnStart + 10
$ssns = $ssnStart..$ssnEnd | ForEach-Object { "$_" }

$people = generate -socialSecurityNumbers $ssns -femaleFirstNames $femaleNames -maleFirstNames $maleNames -lastNames $lastNames -cityNames $cityNames -streetSuffixes $streetSuffixes -stateCodes $stateCodes

$insertBatchSize = 1000

foreach ($person in $people) {
    Write-Host $person
    $insertSql = "INSERT INTO person 
    (
        ssn, 
        first_name, 
        last_name, 
        sex_code, 
        street_address, 
        city_name, 
        state_code, 
        zip, 
        net_worth_amount
    ) 
        VALUES " 
    }




# from os import path
# import psycopg2

# basepath = path.dirname(__file__)
# try:

# connection = psycopg2.connect(host=secrets['pgHost'], database=secrets['pgDatabase'],
#                               user=secrets['pgUsername'], password=secrets['pgPassword'])
# cur = connection.cursor()


# print('Dropping tables if they exist')
# dropSql = open(path.abspath(
#     path.join(basepath, "..", "scripts", 'drop_tables.sql')))
# cur.execute(dropSql.read())
# connection.commit()

# print('Creating the tables')
# createSql = open(path.abspath(
#     path.join(basepath, "..", "scripts", 'create_tables.sql')))
# cur.execute(createSql.read())
# connection.commit()

# # seed the tables with data

# # batch insert

# values = []



# insertBatchSize = 1000

# for p in person_generator.generate(socialSecurityNumbers, femaleNames, maleNames, lastNames, cityNames, streetSuffixes, stateCodes):
#     values.append("('%s', '%s', '%s', '%s', '%s', '%s', '%s','%s', %d)" % (
#                   p['ssn'],
#                   p['firstName'].replace("'", "''"),
#                   p['lastName'].replace("'", "''"),
#                   p['sex'],
#                   p['street'].replace("'", "''"),
#                   p['city'].replace("'", "''"),
#                   p['state'],
#                   p['zip'],
#                   p['netWorth']))
#     if (len(values) == insertBatchSize):
#         print("inserting " + str(insertBatchSize ))
#         insertSql = "INSERT INTO person (ssn, first_name, last_name, sex_code, street_address, city_name, state_code, zip, net_worth_amount) VALUES" + ",".join(values)
#         cur.execute(insertSql)
#         connection.commit()
#         values.clear()

# if(len(values) > 0 ):
#     print("inserting " + str(len(values) ))
#     insertSql = "INSERT INTO person (ssn, first_name, last_name, sex_code, street_address, city_name, state_code, zip, net_worth_amount) VALUES" + ",".join(values)
#     cur.execute(insertSql)
#     connection.commit()

# connection.close()
