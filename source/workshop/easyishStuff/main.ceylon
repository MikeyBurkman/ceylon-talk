
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