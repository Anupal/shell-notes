# C# notes

Following https://www.youtube.com/watch?v=YrtFtdTTfv0
#### static
- belong to the type (class) itself and shared by all instances
- **variables:** shared by all instances. Modifications reflected in all.
- **function:** can be called by the class itself. No need for an instance to be created.
- **class:** can only contain static members, cannot be instantiated.
- **constructor:** used to initialize static members of a class when the class is first accessed. It is called automatically when any static member is referenced for the first time or when the class is loaded.

```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace MyFirstProject
{
    internal class Program
    {
        static void Basics()
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
        }

        static void Stuff1()
        {
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

            const int vat = 20;
            Console.WriteLine(vat);
        }

        static void ConsoleIO()
        {
            Console.Write("Enter something: ");
            string input1 = Console.ReadLine();

            Console.Write("Enter something else: ");
            string input2 = Console.ReadLine();

            Console.Write("Enter an integer: ");
            int input3 = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("\nYou entered '" + input1 + "' and '" + input2 + "' and " + input3);
        }

        static void Conditionals()
        {
            Console.Write("Enter an integer value: ");
            int value = Convert.ToInt32(Console.ReadLine());

            if (value > 0 && value < 100)
            {
                Console.WriteLine("Value is between (0, 100)");
            }
            else
            {
                Console.WriteLine("Out of bounds!");
            }

            Console.Write("Enter day of the week (1-7): ");
            int day = Convert.ToInt32(Console.ReadLine());

            switch (day)
            {
                case 1:
                    Console.WriteLine("Mon");
                    break;
                case 2:
                    Console.WriteLine("Tue");
                    break;
                case 3:
                    Console.WriteLine("Wed");
                    break;
                case 4:
                    Console.WriteLine("Thu");
                    break;
                case 5:
                    Console.WriteLine("Fri");
                    break;
                case 6:
                    Console.WriteLine("Sat");
                    break;
                case 7:
                    Console.WriteLine("Mon");
                    break;
                default:
                    Console.WriteLine("Invalid day!");
                    break;
            }
        }

        static void Loops()
        {
            //for (int i = 0; i < 10; i++)
            for (int i = 0; i < 10; i += 2)
            {
                Console.WriteLine(i);
            }

            Console.WriteLine("--------");

            int j = 0;
            while (j < 10)
            {
                Console.WriteLine(j);
                j += 1;
            }
        }

        static void Stuff2()
        {
            int j = 10;
            // Conditional operator
            Console.WriteLine(j == 10 ? "j=10" : "j!=10");

            /*                 Format string                     */
            // precision
            double someDoubleVal = 1000D / 12.34D;
            Console.WriteLine("original value = {0} and precision value = {0:0.00}", someDoubleVal);
            // 0.# will strip all values after decimal point


            /*             TryParse - try to convert value from string               */
            int testNum = 0;
            // set the value to variable if conversion is successful, else leave it as it is
            // it also returns true or false

            if (!int.TryParse("10h", out testNum))
            {
                Console.Write("conversion unsucessful!\n");
            }

            Console.WriteLine("converted value = " + testNum);
        }

        static void FizzBuzz()
        {
            Console.Write("Enter max number: ");
            int maxVal = 10;
            int.TryParse(Console.ReadLine(), out maxVal);
            for (int i = 1; i <= maxVal; i++)
            {
                if (i % 3 == 0 && i % 5 == 0)
                {
                    Console.WriteLine("FizzBuzz");
                }
                else if (i % 3 == 0)
                {
                    Console.WriteLine("Fizz");
                }
                else if (i % 5 == 0)
                {
                    Console.WriteLine("Buzz");
                }
                else
                {
                    Console.WriteLine(i);
                }
            }
        }

        static void Stuff3()
        {
            // Verbatim string literal
            // --- doesn't need backslashes
            // good for storing paths
            // " will need to be typed twice to be displayed
            Console.WriteLine(@"hello /\/\ $ "" '' whateeer -^%&£ ... \n \0");

            // String interpolation - use variables directly within strings
            string fname = "Anupal";
            Console.WriteLine($"Hello, I am {fname}");

            // String concat
            // string str4 = string.Concat(str1, str2, str3)
            // can also take a list of string as argument

            string emptyString = string.Empty;

            // use str1.Equals(str2) instead of == in if
            // there are edge cases where == will evaluate 
        }

        static void Stuff4()
        {
            // strings are indexed as usual str[0]
            string message = "C# is awesome!";

            for (int i = 0; i < message.Length; i++)
            {
                Console.Write(message[i]);
                Thread.Sleep(250);
            }

            // string functions
            // str1.Contains(str2);

            // use this to avoid null pointer exception
            // string.IsNullOrEmpty(str1)   // string str1 = null;
        }

        static void StringLineByLinePrint(string str)
        {
            for (int i = 0; i < str.Length; i++)
            {
                Console.WriteLine(str[i]);
            }

            for (int i = str.Length - 1; i >= 0; i--)
            {
                Console.WriteLine(str[i]);
            }
        }

        static void PasswordConfirm()
        {
            bool firstPswdCheck = true;
            string firstPswd = null;
            while (firstPswdCheck)
            {
                Console.Write("Enter password: ");
                firstPswd = Console.ReadLine();
                if (!string.IsNullOrEmpty(firstPswd))
                {
                    firstPswdCheck = false;
                }
            }

            bool secondPswdCheck = true;
            string secondPswd = null;
            while (secondPswdCheck)
            {
                Console.Write("Enter password to confirm: ");
                secondPswd = Console.ReadLine();
                if (!string.IsNullOrEmpty(secondPswd))
                {
                    secondPswdCheck = false;
                }
            }

            // check if passwords match
            if (firstPswd.Equals(secondPswd))
            {
                Console.WriteLine("Passwords match");
            }
            else
            {
                Console.WriteLine("Passwords do not match");
            }

        }

        static void PrintArray(int[] arr)
        {
            foreach (int num in arr)
            {
                Console.Write($"{num} ");
            }
            Console.WriteLine();
        }

        static void ArraysTutorial()
        {
            // declare an array
            int[] testArray = new int[3];

            // default value of all elements is 0
            for (int i = 0; i < 3; i++)
            {
                Console.Write($"{testArray[i]} ");
            }
            Console.WriteLine();

            // define an array
            int[] testArray2 = { 1, 2, 3, 4 };

            //foreach
            foreach (int num in testArray2)
            {
                Console.Write($"{num} ");
            }
            Console.WriteLine();

            // sorting -- sorts in place
            int[] arr = { 2, 9, 1, 5, 4, 9, 6 };
            Array.Sort(arr);
            PrintArray(arr);

            // reverse - in place
            Array.Reverse(arr);
            PrintArray(arr);

            // set values of subarray to default value (0 in case of int)
            // Array.Clear(arr, 0, arr.Length);
            // PrintArray(arr);
            // note: can also do this manually using a loop and 'default' keyword.

            // search for value and return its index (first occurence)
            // return -1 if not found can also specify start & end index
            Console.WriteLine("pos {0}", Array.IndexOf(arr, 9));
        }

        static void TriangleAngleSum()
        {
            int[] angles = new int[3];
            for (int i = 0; i < 3; i++)
            {
                Console.Write($"Enter angle {i + 1}: ");
                int.TryParse(Console.ReadLine(), out angles[i]);
            }
            // check sum
            if (angles.Sum() == 180)
            {
                Console.WriteLine("Triangle");
            }
            else
            {
                Console.WriteLine("Not a triangle");
            }
        }

        static void PrintList(List<int> list)
        {
            foreach (int num in list)
            {
                Console.Write($"{num} ");
            }
            Console.WriteLine();
        }

        static void ListsTutorial()
        {
            // declare a list
            List<int> testList = new List<int>(3);
            testList.Add(1);
            testList.Add(2);
            testList.Add(3);
            PrintList(testList);

            // define a list
            List<int> preFilledList = new List<int> { 1, 2, 3, 4, 5 };
            PrintList(preFilledList);

            // remove element at index
            preFilledList.RemoveAt(4);
            PrintList(preFilledList);

            // remove element
            preFilledList.Remove(1);
            PrintList(preFilledList);
        }

        static void PrintDictionary(Dictionary<int, string> dict)
        {
            // this also works
            //foreach (int key in dict.Keys)
            //{
            //    Console.WriteLine($"{key} : {dict[key]}");
            //}

            foreach (KeyValuePair<int, string> pair in dict)
            {
                Console.WriteLine($"{pair.Key} : {pair.Value}");
            }
        }
        static void DictionaryTutorial()
        {
            // define and use
            Dictionary<int, string> dict = new Dictionary<int, string>();
            dict.Add(0, "hello");
            dict.Add(1, "sup");
            dict.Add(2, "yolo");
            PrintDictionary(dict);

            // declare and use
            Dictionary<int, string> dict2 = new Dictionary<int, string>()
            {
                {23, "anupal"},
                {12, "anupal"}
            };
            PrintDictionary(dict2);

            // check if key exists
            if (dict2.ContainsKey(23))
            {
                Console.WriteLine(dict2[23]);
            }
        }

        static void EvenOddLists(int max)
        {
            List<int> evenList = new List<int>(), oddList = new List<int>();

            for (int i = 1; i <= max; i++)
            {
                if (i % 2 == 0) { evenList.Add(i); }
                else { oddList.Add(i); }
            }
            PrintList(oddList);
            PrintList(evenList);
        }

        static void ListOfMultiples(int num, int length)
        {
            List<int> multiples = new List<int>();
            for (int i = 1; i <= length; i++)
            {
                multiples.Add(i * num);
            }
            PrintList(multiples);
        }

        static int ExampleAddition(int a, int b = 50)
        {
            // demonstrates optional parameters
            return a + b;
        }

        // Optional keyword - sets value of parameter to default value of type (in case not passed)
        static void OpKeyEx([Optional] int x)
        {
            Console.WriteLine(x);
        }

        // Named parameters - cannot be followed by unnamed arguments (like Python)
        static void NamedParams(string name, int age, string address)
        {
            Console.WriteLine($"{name} {age} {address}");
        }

        // Out params - way to return more than one value
        // when using out, the out value needs to be assigned a new value in the function
        static int OutParams(out int num)
        {
            num = 5;
            return 0;
        }

        // Passing by reference
        // unlike out, you don't need to assign new value
        static int RefParams(ref int num)
        {
            return 0;
        }

        static void FunctionsExamples() {
            Console.WriteLine(ExampleAddition(1));
            OpKeyEx();
            NamedParams(age: 10, name: "anupal", address: "abcd efghijk");

            int num = 10;
            Console.WriteLine($"Before: {num}");
            int ret = OutParams(out num);
            Console.WriteLine($"After: {num}, returned value: {ret}");

            ret = RefParams(ref num);
        }

        static void ExceptionHandling()
        {
            Console.Write("Enter a number: ");
            string input = Console.ReadLine();

            try
            {
                int num = Convert.ToInt32(input);
                Console.WriteLine(num);
            }
            catch (FormatException)
            {
                Console.WriteLine("Not an integer.");
            }
            catch (OverflowException) 
            {
                Console.WriteLine("Number too large to fit in 32bits.");
            }
            catch (Exception e) // using Exception will catch all exceptions
            {
                Console.WriteLine($"Error: {e.Message}");
            }
        }

        static bool CustomTryParse(string input, out int result)
        {
            try
            {
                result = Convert.ToInt32(input);
                return true;
            } catch (Exception)
            {
                result = -1;
                return false;
            }
        }

        static void Main(string[] args)
        {
            // Basics();
            // Stuff1();
            // ConsoleIO();
            // Conditionals();
            // Loops();
            // Stuff2();
            // FizzBuzz();
            // Stuff3();
            // Stuff4();
            // StringLineByLinePrint("abcdefghijklmnopqrstuvwxyz");
            // PasswordConfirm();
            // ArraysTutorial();
            // TriangleAngleSum();
            // ListsTutorial();
            // DictionaryTutorial();
            // EvenOddLists(20);
            // ListOfMultiples(9, 10);
            // FunctionsExamples();
            // ExceptionHandling();
            int num = 0;
            bool ret_val = CustomTryParse("45a", out num);
            Console.WriteLine($"{ret_val} : {num}");
        }
    }
}
```
