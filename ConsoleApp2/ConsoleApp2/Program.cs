using System;
using RDotNet;

namespace MyProject {
    class Program {
        static void Main(string[] args) {
            // Create an instance of the REngine
            REngine engine = REngine.GetInstance();

            // Evaluate an R expression
            engine.Evaluate("x <- c(1, 2, 3, 4, 5)");
            engine.Evaluate("mean(x)");

            // Get the result as a string
            string result = engine.Evaluate("paste('The mean of x is', mean(x))").AsCharacter().First();

            // Print the result to the console
            Console.WriteLine(result);

            // Dispose of the REngine
            engine.Dispose();
        }
    }
}
