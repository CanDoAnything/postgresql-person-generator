using System;

namespace CanDoAnything
{
    public class Person
    {
        public string SocialSecurityNumber { get; internal set; }
        public string FirstName { get; internal set; }
        public string LastName { get; internal set; }

        public string SexCode { get; internal set; }
        public string Street { get; internal set; }
        public string City { get; internal set; }
        public string StateCode { get; internal set; }
        public string Zipcode { get; internal set; }
        public DateTime GeneratedTimestamp { get; internal set; }
        public long NetWorth { get; internal set; }
    }
}