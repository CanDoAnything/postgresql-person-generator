# use pg driver

$sysmemPath = $PSScriptRoot + '\System.Memory.dll'
Import-module $sysmemPath

$unsafePath = $PSScriptRoot + '\System.Runtime.CompilerServices.Unsafe.dll'
Import-module $unsafePath

$tasksPath = $PSScriptRoot + '\System.Threading.Tasks.Extensions.dll'
Import-module $tasksPath

$npgsqlPath = $PSScriptRoot + '\Npgsql.dll'
Import-Module $npgsqlPath

$secretsFilePath = $PSScriptRoot + "\..\secrets.json"
$personGenInclude = $PSScriptRoot + "\person_generator.ps1"
."$personGenInclude"

$secrets = Get-Content -Raw -Path $secretsFilePath | ConvertFrom-Json
$cn = New-Object Npgsql.NpgsqlConnection
$cn.ConnectionString = "Server=$($secrets.pgHost);Port=5432;Database=$($secrets.pgDatabase);User id=$($secrets.pgUsername);Password=$($secrets.pgPassword)"

$cmd = New-Object Npgsql.NpgsqlCommand
$cmd.Connection = $cn
$cn.Open() 

write-host 'Dropping tables if they exist'
$cmd.CommandText = Get-Content ($PSScriptRoot + '\..\scripts\drop_tables.sql')
$cmd.ExecuteNonQuery()

write-host 'Creating the tables'
$cmd.CommandText = Get-Content ($PSScriptRoot + '\..\scripts\create_tables.sql')
$cmd.ExecuteNonQuery()

$femaleNames = (Import-Csv ($PSScriptRoot + "\..\data\first_names_female.csv") -Header "Name").Name
$maleNames = (Import-Csv ($PSScriptRoot + "\..\data\first_names_male.csv") -Header "Name").Name
$lastNames = (Import-Csv ($PSScriptRoot + "\..\data\last_names.csv") -Header "Name").Name
$cityNames = (Import-Csv ($PSScriptRoot + "\..\data\city_names.csv") -Header "Name").Name
$stateCodes = (Import-Csv ($PSScriptRoot + "\..\data\state_codes.csv") -Header "Code").Code
$streetSuffixes = (Import-Csv ($PSScriptRoot + "\..\data\street_suffixes.csv") -Header "Suffix").Suffix


$quantity = 500000
$ssnStart = 123456789
$ssnEnd = $ssnStart + $quantity - 1
$ssns = $ssnStart..$ssnEnd | ForEach-Object { "$_" }
write-host "Generating $($ssnEnd - $ssnStart+1) records..."
$people = generate -socialSecurityNumbers $ssns -femaleFirstNames $femaleNames -maleFirstNames $maleNames -lastNames $lastNames -cityNames $cityNames -streetSuffixes $streetSuffixes -stateCodes $stateCodes

$insertBatchSize = 1000
$values = New-Object System.Collections.ArrayList

foreach ($person in $people) {
    $currentBatchSize = $values.Add("('$($person.ssn)','$($person.firstName)',
    '$($person.lastName -replace "'", "''")',
    '$($person.sex)',
    '$($person.street -replace "'", "''")',
    '$($person.city -replace "'", "''")',
    '$($person.state)',
    '$($person.zip)',
    '$($person.netWorth)',
    '$($person.generatedTimestamp)'
    )")
    
    if ($currentBatchSize -eq $insertBatchSize - 1) {
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
            net_worth_amount,
            generated_timestamp
        ) 
            VALUES $($values -join ',')" 
        $cmd.CommandText = $insertSql
        $cmd.ExecuteNonQuery()
        $values.clear()
    }
}
if ($values.Count -gt 0) {


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
    net_worth_amount,
    generated_timestamp
) 
    VALUES $($values -join ',')" 
    $cmd.CommandText = $insertSql
    $cmd.ExecuteNonQuery()
}

$cmd.CommandText = Get-Content ($PSScriptRoot + '\..\scripts\speed_statistics.sql')
$reader = $cmd.ExecuteReader()

$reader.read()

Add-Content -Path ($PSScriptRoot + "\..\observations.md") -NoNewline -Value "|$($reader.GetDouble(0))|$($reader.GetInterval(1))|$($reader.GetInterval(2))|PowerShell|$($reader.GetString(3))|`r"


$cn.Close()

