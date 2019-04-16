from random import randint

def generateOne(femaleFirstNames, maleFirstNames, lastNames):
    person = dict()
    person['firstName'] =  "Bob"
    person['lastName'] = "Smith"
    person['gender']= "M"
    return  person

def generateMany(femaleFirstNames, maleFirstNames, lastNames,quantity=100):
    people = []
    person = dict()

    ffnCount = len(femaleFirstNames)

    for i in range(quantity):
        person['firstName'] =  randint(0,ffnCount)
        person['lastName'] = "Smith"
        person['gender']= "M"
        people.append(person)
    return  people