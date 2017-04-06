
"Shows creating variables and basic types in Ceylon"
shared void basicTypesExample() {
    String str1 = "abc";
    Boolean bool1 = true;
    Character char1 = 'z';

    // There are also only two basic number types:
    Integer int1 = 123;
    Float float1 = 3.1415;

    // Printing to console available through the print() function
    print(str1);
    // Type-safe string interpolation using `` `` inside strings:
    print("Value of int1: ``int1``");

    // Note that there are primitives! Everything's ACTUALLY an object.
    // Adding numbers is actually syntactic sugar for calling the "plus()" method!
    // (This is actual polymorphism)
    print("``int1`` + 5 = ``int1.plus(5)``");
}

"Example of tuples"
shared void tupleExample() {
    Integer int1 = 42;
    [String, Integer, Float] tuple1 = ["xyz", int1, 99.0];
    print("Tuple = ``tuple1``");

    String str2 = tuple1[0];
    Integer int2 = tuple1[1];
}

"Shows how to create iterables and sequences"
shared void iterablesExample() {
    // Iterables (AKA Streams) can be defined using { }
    {String*} iterable1 = { "a", "b", "c" };
    // Use {Type+} to indicate a non-empty iterable
    {String+} iterable2 = { "d", "e", "f" };
    //{String+} empty = { }; // Compile error!


    // There are also sequences, which are similar to arrays.
    // These are subclasses of iterable
    [String*] sequence1 = [ "a", "b", "c" ];
    String[] sequence2 = [ "d", "e", "f" ]; // Alternate syntax, same as [String*]
    
    // Basic iterating can be done with a for loop
    for (String s in iterable1) {
        print("Iterable 1 value: ``s``");
    }

    // Ranges are pretty easy
    {Integer*} range1 = 1..5;
    for (i in range1) {
        print("i = ``i``");
    }
}

"Shows how to make mutable variables instead of immutable ones"
shared void mutableVariablesExample() {
    // Variable are immutable by default (AKA: "final" in Java)
    String str1 = "abc";
    // str1 = "def"; // Compile error!

    // You can make them mutable aby adding "variable" out front
    variable String str2 = "aaa";
    str2 = "bbb"; // Now compiles
    print("Value of str2 after change: ``str2``");

    // Note that elements in Tuples and Sequences are immutable as well
    [Integer, String] tuple1 = [11, "abc"];
    //tuple1[0] = 42; // Compile error!
    // Tuples can never be made mutable - You can only make new copies

    [Character+] sequence1 = ['B', 'C', 'D'];
    // sequence1[0] = 'A'; // Compile error!
}

// Shows basic type inference
shared void typeInferenceExample() {
    // Type inference allows the compiler to detect the type of variables in many cases
    value str1 = "abc";
    value int1 = 123;
    value float1 = 3.1415;

    // Note that the type is NOT dynamic!
    variable value str2 = "ttt";
    // str2 = 14; // Compile error! Cannot assign an Integer to a String

    // Note: Type inference only works for local variables
}


shared void functionsExample() {
    // Look much like Java, but can be written at just about any level
    Integer double(Integer i) {
        return i * 2;
    }
    print("double(3) = ``double(3)``");

    // Ceylon also supports expressions for single-line functions
    Integer(Integer) sqr = (Integer i) => i * i;
    print("sqr(5) = ``sqr(5)``");

    // Functions are first-class in Ceylon, which means they be used like other types
    Integer(Integer) doubleRef = double;
    print("doubleRef(10) = ``doubleRef(10)``");

    // Functions can make use of type inference too
    value sqrRef = sqr;
    print("sqrRef(6) = ``sqrRef(6)``");

    // Even for return values sometimes
    function triplet(Integer i) {
        return [i, i * 2, i * 3];
    }
    print("triplet(3) = ``triplet(3)``");
}

"Default args, named args, var args, oh my"
shared void advancedFunctionExamples() {

    // Default arguments are supported
    void foo(String s1, String s2 = "111111") {
        print("Foo: ``s1`` -- ``s2``");
    }
    foo("a", "b");
    foo("a");

    // As are named arguments -- but call with { } instead of ( )
    // Separate args with semi-colon
    foo {
        s1 = "c";
        s2 = "d";
    };

    // Varargs
    void bar(String* args) {
        print("First bar call");
        for (s in args) {
            print("Arg: ``s``");
        }
        print("Last call!");
    }

    bar();
    bar("a", "b", "c");

    // Non-empty varargs are similar to iterables
    void nonEmptyBar(String+ args) {

    }
    nonEmptyBar("x"); // Legal
    // nonEmptyBar(); // Compile error!


    // Lastly, you use the spread operator to call a function with a tuple!
    value tuple = ["yes this", "works"];
    foo(*tuple); // Yeah this is getting pretty fancy -- this could be a whole discussion in itself
}

"Basic functional programming (ish) constructors"
shared void mapFilterYay() {
    value iterable = { 1, 2, 3, 4, 5};

    function isEven(Integer x) => x % 2 == 0;
    
    value result = iterable
        .map((x) => x * x) // Square each number
        .filter(isEven)
        .sort(byIncreasing((Object x) => x.string)); // Type inference kind of fails here unfortunately
    print("Result = ``result``");

    // Note that these functions acting on Iterables are LAZY
    // If acting on Sequences, they are EAGER
    // (Of course, sort() calls will return a Sequence, since order is not explicitly defined on iterables)
}

"If/Else and switch statements"
shared void basicControlStructures() {
    // If/else works very similar to Java
    if (2 > 0) {
        print("2 > 0: yup");
    } else {
        print("My math is broken");
    }

    // If/else can actually be used as an expression though!
    // (Similar to ternary expressions, but a bit more verbose and hopefully easier to read)
    String result = if (2 > 0) then "yes" else "no";
    print("Result = ``result``");

    // Switch statements are cooler now.
    // Also, no fall-through behavior!

    void foo(String s) {
        switch (s)
            case("A") { print("Its an A"); }
            case("B"|"C") { print("B or C then"); }
            else { print("Something else"); }
    }

    foo("A");
    foo("B");
    foo("C");
    foo("D");
}
