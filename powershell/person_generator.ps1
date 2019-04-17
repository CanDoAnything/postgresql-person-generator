function generate([String[]] $socialSecurityNumbers,
    [String[]] $femaleFirstNames,
    [String[]] $maleFirstNames,
    [String[]] $lastNames,
    [String[]] $cityNames,
    [String[]] $streetSuffixes,
    [String[]] $stateCodes
) {
    $people = New-Object System.Collections.ArrayList

    foreach ($ssn in $socialSecurityNumbers) {
        if ((Get-Random -Maximum 100) % 2 -eq 0) {
            $firstName = $maleFirstNames[(Get-Random -Maximum ($maleFirstNames.Count - 1))];
            $sex = "M";
        }
        else {
            $firstName = $femaleFirstNames[(Get-Random -Maximum ($femaleFirstNames.Count - 1))];
            $sex = "F";
        }

        $wealthLevel = Get-Random -Maximum 10000
        if ($wealthLevel -lt 9000) {
            $netWorth = Get-Random -Maximum 50000
        }
        elseif ($wealthLevel -ge 9000 -and $wealthLevel -lt 9995) {
            $netWorth = Get-Random -Minimum 50000 -Maximum 1000000
        }
        elseif ($wealthLevel -ge 9995 -and $wealthLevel -lt 9999) {
            $netWorth = Get-Random -Minimum 100000 -Maximum 10000000
        }
        else {
            $netWorth = Get-Random -Minimum 1000000 -Maximum 10000000000 
        }

        $person = New-Object -TypeName PSObject -Property @{
            ssn       = $ssn;
            firstName = $firstName
            lastName  = $lastNames[(Get-Random -Maximum ($lastNames.Count - 1))];
            street    = "$(Get-Random -Minimum 10 -Maximum 40000) $($cityNames[(Get-Random -Maximum ($cityNames.Count-1))]) $($streetSuffixes[(Get-Random -Maximum ($streetSuffixes.Count-1))])"
            city      = $cityNames[(Get-Random -Maximum ($cityNames.Count - 1))];
            state     = $stateCodes[(Get-Random -Maximum ($stateCodes.Count - 1))];
            zip       = Get-Random -Minimum 10000 -Maximum 99999
            sex       = $sex
            netWorth  = $netWorth
        }
        $people.Add($person)

        
        
    }
    return $people
}

# def generate(socialSecurityNumbers, femaleFirstNames, maleFirstNames, lastNames, cityNames, streetSuffixes, stateCodes):
#     people = []

#     quantity = len(socialSecurityNumbers)

#     maleRandoms = [randint(0, len(maleFirstNames)) for p in range(0, quantity)]
#     femaleRandoms = [randint(0, len(femaleFirstNames))
#                      for p in range(0, quantity)]
#     lnRandoms = [randint(0, len(lastNames)) for p in range(0, quantity)]
#     cityRandoms = [randint(0, len(cityNames)) for p in range(0, quantity)]
#     streetRandoms = [randint(0, len(cityNames)) for p in range(0, quantity)]

#     for i in range(quantity):
#         person = dict()

#         if(randint(0, 100) % 2 == 0):
#             person['sex'] = "M"
#             person['firstName'] = maleFirstNames[maleRandoms[i]-1]

#         else:
#             person['sex'] = "F"
#             person['firstName'] = femaleFirstNames[femaleRandoms[i]-1]

#         person['lastName'] = lastNames[lnRandoms[i]-1]
#         person['ssn'] = socialSecurityNumbers[i]

#         person['street'] = str(randint(10, 40000)) + " " + cityNames[streetRandoms[i]-1] + \
#             " " + streetSuffixes[randint(0, len(streetSuffixes)-1)]
#         person['city'] = cityNames[cityRandoms[i]-1]
#         person['state'] = stateCodes[randint(0, len(stateCodes)-1)]
#         person['zip'] = str(randint(10000, 99999))

#         wealthLevel = randint(0, 10000)
#         if (wealthLevel < 9000):
#             person['netWorth'] = randint(0, 50000)
#         elif (wealthLevel >= 9000 and wealthLevel < 9995):
#             person['netWorth'] = randint(50000, 1000000)
#         elif (wealthLevel >= 9995 and wealthLevel < 9999):
#             person['netWorth'] = randint(100000, 10000000)
#         else:
#             person['netWorth'] = randint(1000000, 10000000000)

#         people.append(person)

#     return people
