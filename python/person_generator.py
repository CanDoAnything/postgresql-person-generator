from random import randint


def generate(femaleFirstNames, maleFirstNames, lastNames, cityNames, quantity=100):
    people = []
    streetSuffixes = [
        "Anex", "Arcade", "Avenue", "Bayou", "Beach", "Bend", "Bluff", "Bluffs", "Bottom", "Boulevard",
        "Branch", "Bridge", "Brook", "Brooks", "Burg", "Burgs", "Bypass", "Camp", "Canyon", "Cape", "Causeway",
        "Center", "Centers", "Circle", "Circles", "Cliff", "Cliffs", "Club", "Common", "Commons",
        "Corner", "Corners", "Course", "Court", "Courts", "Cove", "Coves", "Creek", "Crescent", "Crest",
        "Crossing", "Crossroad", "Crossroads", "Curve", "Dale", "Dam", "Divide", "Drive", "Drives",
        "Estate", "Estates", "Expressway", "Extension", "Extensions", "Fall", "Falls", "Ferry",
        "Field", "Fields", "Flat", "Flats", "Ford", "Fords", "Forest", "Forge", "Forges", "Fork",
        "Forks", "Fort", "Freeway", "Garden", "Gardens", "Gateway", "Glen", "Glens", "Green", "Greens",
        "Grove", "Groves", "Harbor", "Harbors", "Haven", "Heights", "Highway", "Hill", "Hills", "Hollow",
        "Inlet", "Island", "Islands", "Isle", "Junction", "Junctions", "Key", "Keys", "Knoll", "Knolls",
        "Lake", "Lakes", "Land", "Landing", "Lane", "Light", "Lights", "Loaf", "Lock", "Locks", "Lodge",
        "Loop", "Mall", "Manor", "Manors", "Meadow", "Meadows", "Mews", "Mill", "Mills", "Mission",
        "Motorway", "Mount", "Mountain", "Mountains", "Neck", "Orchard", "Oval", "Overpass", "Park",
        "Parks", "Parkway", "Parkways", "Pass", "Passage", "Path", "Pike", "Pine", "Pines", "Place",
        "Plain", "Plains", "Plaza", "Point", "Points", "Port", "Ports", "Prairie", "Radial", "Ramp",
        "Ranch", "Rapid", "Rapids", "Rest", "Ridge", "Ridges", "River", "Road", "Roads", "Route",
        "Row", "Rue", "Run", "Shoal", "Shoals", "Shore", "Shores", "Skyway", "Spring", "Springs",
        "Spur", "Spurs", "Square", "Squares", "Station", "Stravenue", "Stream", "Street", "Streets",
        "Summit", "Terrace", "Throughway", "Trace", "Track", "Trafficway", "Trail", "Trailer",
        "Tunnel", "Turnpike", "Underpass", "Union", "Unions", "Valley", "Valleys", "Viaduct",
        "View", "Views", "Village", "Villages", "Ville", "Vista", "Walk", "Walks", "Wall", "Way",
        "Ways", "Well", "Wells"
    ]

    stateCodes = [
        "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "GU", "HI", "ID",
        "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MH", "MA", "MI", "FM", "MN", "MS", "MO", "MT", "NE",
        "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD",
        "TN", "TX", "UT", "VT", "VA", "VI", "WA", "WV", "WI", "WY"
    ]

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
        person['ssn'] = str(randint(100, 999)) + "-" + \
            str(randint(10, 99)) + "-"+str(randint(1000, 9999))

        person['street'] = str(randint(10, 40000)) + " " + cityNames[cityRandoms[i]-1] + \
            " " + streetSuffixes[randint(0, len(streetSuffixes)-1)]
        person['city'] = cityNames[cityRandoms[i]-1]
        person['state'] = stateCodes[randint(0, len(stateCodes)-1)]
        person['zip'] = str(randint(10000, 99999))

        wealthLevel = randint(0, 100)
        if (wealthLevel < 70):
            person['netWorth'] = randint(0, 50000)
        elif (wealthLevel >= 70 and wealthLevel < 95):
            person['netWorth'] = randint(50000, 1000000)
        elif (wealthLevel >= 95 and wealthLevel < 99):
            person['netWorth'] = randint(1000000, 10000000)
        else:
            person['netWorth'] = randint(10000000, 10000000000)

        people.append(person)

    return people
