using System;
using Npgsql;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.IO;
using System.Reflection;

namespace CanDoAnything
{
    class Program
    {
        static void Main(string[] args)
        {
            string root = System.IO.Directory.GetParent(Environment.CurrentDirectory).ToString();
            string json = System.IO.File.ReadAllText(System.IO.Path.Combine(root, "secrets.json"));
            var secrets = JObject.Parse(json);

            NpgsqlConnection cn = new NpgsqlConnection();
            cn.ConnectionString = $"Server={secrets["pgHost"]};Port=5432;Database={secrets["pgDatabase"]};User id={secrets["pgUsername"]};Password={secrets["pgPassword"]}";
            cn.Open();
            cn.Close();

            NpgsqlCommand cmd = new NpgsqlCommand();
            cmd.Connection = cn;
            cn.Open();

            Console.WriteLine("Dropping tables if they exist");

            cmd.CommandText = System.IO.File
            .ReadAllText(System.IO.Path
            .Combine(root, "scripts", "drop_tables.sql"));

            cmd.ExecuteNonQuery();


            Console.WriteLine("Creating the tables");
            cmd.CommandText = System.IO.File
                .ReadAllText(System.IO.Path
                .Combine(root, "scripts", "create_tables.sql"));
            cmd.ExecuteNonQuery();

            string[] femaleNames = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "first_names_female.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            string[] maleNames = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "first_names_male.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            string[] lastNames = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "last_names.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            string[] cityNames = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "city_names.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            string[] stateCodes = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "state_codes.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            string[] streetSuffixes = System.IO.File
                    .ReadAllText(System.IO.Path.Combine(root, "data", "street_suffixes.csv"))
                    .Split(new[] { Environment.NewLine }, StringSplitOptions.None);

            int quantity = 500000;
            int ssnStart = 123456789;
            int ssnEnd = ssnStart + quantity - 1;

            IEnumerable<string> ssns = Enumerable.Range(ssnStart, quantity).Select(a => a.ToString());

            Console.WriteLine($"Generating {ssnEnd - ssnStart + 1} records...");

            PersonGenerator pg = new PersonGenerator();
            pg.FemaleFirstNames = femaleNames;
            pg.MaleFirstNames = maleNames;
            pg.LastNames = lastNames;
            pg.CityNames = cityNames;
            pg.StateCodes = stateCodes;
            pg.StreetSuffixes = streetSuffixes;

            IEnumerable<Person> people = pg.Generate(ssns);

            int insertBatchSize = 1000;
            List<string> values = new List<string>();

            foreach (Person p in people)
            {
                values.Add($"('{p.SocialSecurityNumber}','{p.FirstName.Replace("'", "''")}','{p.LastName.Replace("'", "'")}','{p.SexCode}','{p.Street.Replace("'", "''")}','{p.City.Replace("'", "''")}','{p.StateCode}','{p.Zipcode}', {p.NetWorth}, '{p.GeneratedTimestamp.ToString("yyyy-MM-dd HH:mm:ss.ffffff")}')");
                if (values.Count == insertBatchSize - 1)
                {
                    string insertSql = $@"INSERT INTO person (ssn, first_name, last_name, sex_code, street_address, city_name, state_code, zip, net_worth_amount, generated_timestamp) VALUES {String.Join(",", values)}";
                    cmd.CommandText = insertSql;
                    cmd.ExecuteNonQuery();
                    values.Clear();
                }
            }
            if (values.Count > 0)
            {
                string insertSql = $@"INSERT INTO person (ssn, first_name, last_name, sex_code, street_address, city_name, state_code, zip, net_worth_amount, generated_timestamp) VALUES {String.Join(",", values)}";
                cmd.CommandText = insertSql;
                cmd.ExecuteNonQuery();
            }

            cmd.CommandText = System.IO.File
            .ReadAllText(System.IO.Path
            .Combine(root, "scripts", "speed_statistics.sql"));
            NpgsqlDataReader reader = cmd.ExecuteReader();
            reader.Read();

            string framework = Assembly
                .GetEntryAssembly()?
                .GetCustomAttribute<System.Runtime.Versioning.TargetFrameworkAttribute>()?
                .FrameworkName;

            using (StreamWriter writer = System.IO.File.AppendText(System.IO.Path.Combine(root, "observations.md")))
            {
                writer.WriteLine($"|{reader.GetDouble(0)}|{reader.GetInterval(1)}|{reader.GetInterval(2)}|{framework}|{reader.GetString(3)}|");
            }


            cn.Close();
        }
    }
}
