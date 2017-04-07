
"Implement fizz-buzz! Iterate the numbers 1 - 100
 * If the number is a multiple of 3, then print 'fizz'
 * If the number is a multiple of 5, then print 'buzz'
 * If the number is a multiple of both 3 and 5, then print 'fizzbuzz'
 * If the number is none of these, just print the number"
shared void fizzBuzzImpl() {
    for (i in 1..100) {
        if (i % 15 == 0) {
            print("fizzbuzz");
        } else if (i % 3 == 0) {
            print("fizz");
        } else if (i % 5 == 0) {
            print("buzz");
        } else {
            print(i);
        }
    }
}

"Write a fibonaci function
 * You probably already know how to do a fibbonaci function
 * Print out the results of fib(n) for 1 through 10"
shared void fibImpl() {
    Integer fib(Integer x) {
        if (x <= 2) {
            return 1;
        } else {
            return fib(x - 1) + fib(x - 2);
        }
    }

    for (i in 1..10) {
        print("Fib(``i``) = ``fib(i)``");
    }
    
}

"Given an iterable of Integers, return an iterable of characters
 of the last digit of each Integer. Use a map function."
shared void rightMostDigitsImpl() {
    {Character+} rightMostDigits({Integer+} nums) {
        function rightDigit(Integer i) => i.string.last else '0';
        return nums.map(rightDigit);
    }

    print(rightMostDigits({1, 12, 443, 6854}));
}

"A triangle number is somehow defined by the sum of the numbers from 1
 until that number. so triangle(3) = 1+2+3 = 6.
 * Print out the triangle numbers for integers 1 through 10.
 * And then maybe explain to me why they're called that because I don't feel like looking it up.
 * Extra credit if you use a fold or reduce function."
shared void triangleNumbersImpl() {
    function triangle(Integer i) =>
            (1..i).fold(0)((sum, n) => sum + n);

    for (n in 1..10) {
        print("Triangle(``n``) = ``triangle(n)``");
    }
}