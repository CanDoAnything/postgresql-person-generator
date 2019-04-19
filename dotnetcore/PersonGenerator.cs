using System;
using System.Collections.Generic;

namespace CanDoAnything
{
    public class PersonGenerator
    {
        public string[] FemaleFirstNames;
        public string[] MaleFirstNames;
        public string[] LastNames;
        public string[] CityNames;
        public string[] StateCodes;
        public string[] StreetSuffixes;

        public IEnumerable<Person> Generate(IEnumerable<string> socialSecurityNumbers)
        {
            List<Person> people = new List<Person>();
            foreach (var ssn in socialSecurityNumbers)
            {
                Person p = new Person();
                p.SocialSecurityNumber = ssn;

                Random random = new Random();

                if (random.Next(0, 100) % 2 == 0)
                {
                    p.FirstName = MaleFirstNames[random.Next(MaleFirstNames.Length - 1)];
                    p.SexCode = "M";
                }
                else
                {
                    p.FirstName = FemaleFirstNames[random.Next(FemaleFirstNames.Length - 1)];
                    p.SexCode = "F";
                }

                p.LastName = LastNames[random.Next(LastNames.Length - 1)];
                p.Street = random.Next(10, 40000).ToString() + " "
                    + CityNames[random.Next(CityNames.Length - 1)] + " "
                    + StreetSuffixes[random.Next(StreetSuffixes.Length - 1)];
                p.City = CityNames[random.Next(CityNames.Length - 1)];
                p.StateCode = StateCodes[random.Next(StateCodes.Length - 1)];
                p.Zipcode = random.Next(10000, 99999).ToString();

                int wealthLevel = random.Next(10000);
                if (wealthLevel < 9000)
                {
                    p.NetWorth = random.Next(50000);
                }
                else if (wealthLevel >= 9000 && wealthLevel < 9995)
                {
                    p.NetWorth = random.Next(50000, 1000000);
                }
                else if (wealthLevel >= 9995 && wealthLevel < 9999)
                {
                    p.NetWorth = random.Next(100000, 10000000);
                }
                else
                {
                    p.NetWorth = random.Next(100000, 1000000000) * 10;
                }
                p.GeneratedTimestamp = DateTime.UtcNow;
                people.Add(p);
            }
            return people;
        }
    }
}