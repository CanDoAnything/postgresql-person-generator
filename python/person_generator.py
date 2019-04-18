from random import randint
import datetime

def generate(socialSecurityNumbers, femaleFirstNames, maleFirstNames, lastNames, cityNames, streetSuffixes, stateCodes):
    people = []

    quantity = len(socialSecurityNumbers)

    maleRandoms = [randint(0, len(maleFirstNames)) for p in range(0, quantity)]
    femaleRandoms = [randint(0, len(femaleFirstNames))
                     for p in range(0, quantity)]
    lnRandoms = [randint(0, len(lastNames)) for p in range(0, quantity)]
    cityRandoms = [randint(0, len(cityNames)) for p in range(0, quantity)]
    streetRandoms = [randint(0, len(cityNames)) for p in range(0, quantity)]

    for i in range(quantity):
        person = dict()

        if(randint(0, 100) % 2 == 0):
            person['sex'] = "M"
            person['firstName'] = maleFirstNames[maleRandoms[i]-1]

        else:
            person['sex'] = "F"
            person['firstName'] = femaleFirstNames[femaleRandoms[i]-1]

        person['lastName'] = lastNames[lnRandoms[i]-1]
        person['ssn'] = socialSecurityNumbers[i]

        person['street'] = str(randint(10, 40000)) + " " + cityNames[streetRandoms[i]-1] + \
            " " + streetSuffixes[randint(0, len(streetSuffixes)-1)]
        person['city'] = cityNames[cityRandoms[i]-1]
        person['state'] = stateCodes[randint(0, len(stateCodes)-1)]
        person['zip'] = str(randint(10000, 99999))

        wealthLevel = randint(0, 10000)
        if (wealthLevel < 9000):
            person['netWorth'] = randint(0, 50000)
        elif (wealthLevel >= 9000 and wealthLevel < 9995):
            person['netWorth'] = randint(50000, 1000000)
        elif (wealthLevel >= 9995 and wealthLevel < 9999):
            person['netWorth'] = randint(100000, 10000000)
        else:
            person['netWorth'] = randint(1000000, 10000000000)

        person['generated_timestamp'] = datetime.datetime.utcnow()
        people.append(person)

    return people
