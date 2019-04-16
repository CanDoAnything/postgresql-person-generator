from random import randint

def generateOne(femaleFirstNames, maleFirstNames, lastNames):
    person = dict()
    person['firstName'] =  "Bob"
    person['lastName'] = "Smith"
    person['gender']= "M"
    return  person

def generateMany(femaleFirstNames, maleFirstNames, lastNames,quantity=100):
    people = []
  

    
    malefnCount = len(maleFirstNames)
    maleRandoms = [randint(0, malefnCount) for p in range(0, quantity)]

    femalefnCount = len(femaleFirstNames) 
    femaleRandoms = [randint(0, femalefnCount) for p in range(0, quantity)]

    lnCount = len(lastNames)
    lnRandoms = [randint(0, lnCount) for p in range(0, quantity)]

    for i in range(quantity):
        person = dict()
        
        if(randint(0,100) % 2 == 0):
            person['firstName'] =  maleFirstNames[maleRandoms[i]-1]
            person['gender']= "M"
        else:
            person['firstName'] =  femaleFirstNames[femaleRandoms[i]-1]
            person['gender']= "F"

        person['lastName'] = lastNames[lnRandoms[i]-1]
        people.append(person)

    return  people