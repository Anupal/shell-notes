# C# notes

Following https://www.youtube.com/watch?v=YrtFtdTTfv0

```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFirstProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            // Can use System directly without importing above
            // System.Console.WriteLine("Hello World!");

            /*  ----------   WORKING WITH NUMBERS  ----------  */
            // int age = 23;
            int age;
            age = 23;
            Console.WriteLine(age);

            // C# assumes all number are int32, you need to use L for int64
            long bigNumber = 900000000L;
            Console.WriteLine(bigNumber);
            // constants
            Console.WriteLine(int.MaxValue);
            Console.WriteLine(int.MinValue);
            Console.WriteLine(long.MaxValue);
            Console.WriteLine(long.MinValue);

            // we can put D at the end of doubles if we want (it is fine if we don't)
            double testDouble1 = 44.7;
            double testDouble2 = 22.3D;
            Console.WriteLine(testDouble1);
            Console.WriteLine(testDouble2);

            // by default decimals are registered as doubles, use F
            // floats covers smaller range than double
            float testFloat1 = 5.000001F;
            Console.WriteLine(testFloat1);

            // decimal is also supported as a type (idk what it is used for)

            // declare together
            // int x, y, z;

            // define together
            int x = 1, y = 2, z = 3;
            // multiline
            int a = 10,
                b = 20,
                c = 30;

            /*  ----------   WORKING WITH STRINGS  ----------  */
            string name = "Anupal"; // string double quotes
            char letter = 'a';      // char single quotes
            // char letter = ''; is not valid as there is not concept of empty character literal use '\0' instead
            // string nam = ""; is valid as is an empty string
            Console.WriteLine(name);
            Console.WriteLine(letter);

            /*  ----------  CONVERTING STRING TO NUMBER TYPES  ---------- */
            string textAge = "-23";
            int convertedTextAge = Convert.ToInt32(textAge);
            Console.WriteLine(convertedTextAge);

            string textBigNumber = "-900000000";
            long convertedTextBigNumber = Convert.ToInt64(textBigNumber); // we don't need L as we use ToInt64 function
            Console.WriteLine(convertedTextBigNumber);

            // .ToSingle for float
            // .ToDecimal for decimal

            Convert.ToInt32("23");
            // Convert.ToInt32("23h"); will throw a runtime error


            /*  ----------   BOOLEAN DATA TYPES  ----------  */
            bool bool1 = true;
            bool bool2 = false;

            /* change variable value */
            int k = 5;
            // k = k + 19;
            // k++
            k += 19;
            Console.WriteLine(k);

            // k /= 10 will result in 2 not 2.4 (as variable type is int32)

            // string concat
            string str1 = "My name is";
            string str2 = " Anupal.";

            str1 += str2;
            Console.WriteLine(str1);

            // we also have ++i and i++
            // int i = 0;
            // Console.WriteLine(++i); will print 1 as i is incremented before passing to the function
            // the actual value will be modified and i will be 1 for all later calls/uses

            // you can add chars but it will result in new chars with unicode value as sum of unicode values

            // % is used to get remainder and can be used to check if the value is even
            int even = 10 % 2;
            Console.WriteLine(even);

            /*    var keyword    */
            // for duck typing - compiler will figure out the type
            var someNumber = 600000000L; // will be int64

            // use var only when the type of variable is obvious, otherwise it impacts the readability of the code
            // you might need to manually check the type by hovering over it

            /*         Constants          */


            Console.ReadLine();
        }
    }
}

```
