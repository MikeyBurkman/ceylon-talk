
"Hey look I can call that function defined in that other file..."
shared void importsExample() {
    // You can import at just about any scope, provided it's at the top
    import talk.part01Basics { basicTypesExample }

    basicTypesExample();
}

"Or, How to avoid the Billion-Dollar Mistake"
shared void nullability() {

    // Null is now its OWN type!
    Null n = null;
    // Null is NOT assignable to anything else
    // String s = null; // Compile error!

    // Null cannot be passed in as an argument to a function that is not expecting Null
    value fn = (String str) => "``str`` ``str``";
    //fn(null); // Nope! Compile error!


    // ... But what I *want* to have something sometimes null?
}

// Arguably the coolest part of this language
shared void unionTypes() {

    // Variables can have *more than one* possible type
    String|Null s1 = "xxx";

    // You won't be able to do much with a null, though
    // s1. // There's nothing in autocomplete!

    // To do anything with a possibly-null value, you must first check if it's null
    if (exists s1) {
        // The type of s1 has been NARROWED to just "String"
        print("s1.size = ``s1.size``"); // Full autocomplete options
    }
    // Outside of the if block, s1 is still String|Null

    // Exists is syntactic sugar around the more general "is" construct:
    if (is String s1) {
        print("s1.size again = ``s1.size``");
    }

    // And if you're really confident that it's not null... (Try to avoid this)
    "s1 should always exist here because I just typed it..."
    assert (exists s1); // Will throw an error if s2 is null

    // Now the type of s1 has been NARROWED to String
    print("s1.size yet again = ``s1.size``");


    // Union types can be as complex as you need them -- Not just for nulls!
    String|Integer|Float|Null x = 4.88;
    if (exists x) {
        // This narrowed the type to String|Integer|Float
        print("x.hash = ``x.hash``"); // Hash is available on String, Integer, and Float
    }

    // There's also syntactic sugar for nullability
    String? s2 = null; // Equivalent to String|Null
    Integer? size = s2?.size; // Equivalent to if (exists s3) then s3.size else null;
    String s2WithDefault = s2 else "Default String"; // Use else to have a default value



    // (One last note: if (x != null) is not valid in Ceylon!)
}

"Here be dragons, if you dig further"
shared void unionTypesInheritance() {
    // Inheritance is well-defined for union types, and fairly intuitive
    // For instance, String is a subtype of String|Integer
    // So you can assign one to the other, just like assigning a String to a variable typed Object
    String val1 = "abc";
    String|Integer val2 = val1;

    // For a good examples of this in practice, here's a function with a union type argument
    void foo(String|Integer arg) {
        if (is String arg) {
            print("It's a string!");
        } else {
            print("It's an integer");
        }
    }

    foo("s");
    foo(43);
}

"Actually works pretty much how you'd want it to"
shared void unionTypesInCollections() {
    // Union types allows us to put disparate types in collections, while still remaining type-safe
    [String|Integer+] seq = ["A", 4, "C"]; // In most other languages, you'd have to settle for List<Object>

    String|Integer v1 = seq[0];
    if (is Integer v1) {
        print("v1.magnitude: ``v1.magnitude``");
    }

    // Assignment can be done inside these blocks:
    if (is Integer v2 = seq[1]) {
        print("v2.magnitude: ``v2.magnitude``");
    }
}

"Or, how to do checked exceptions better"
shared void errorConditions() {
    // Union types all of a sudden give us a more friendly (and efficient) way of
    //  indicating certain more-expected error conditions
    // For instance, parsing an integer is very likely to lead to failure

    void parse(String s) {
        value result = Integer.parse(s);
        if (is Integer result) {
            print("Parsed ``result`` just fine");
        } else {
            // Type  of result is now ParseException
            print("Error parsing ``s``: ``result.message``");
        }
    }

    parse("14");
    parse("abc");

    // However, there are times when runtime exceptions are appropriate, and they are supported.
    // In general, exceptions are thrown when you would expect most people to simply bubble up the exception anyways.
    // Use your best judgement. And read this https://ceylon-lang.org/blog/2015/12/14/failure/
    void thisWillFail() {
        throw Exception("Yep here's an exception for you");
    }

    try {
        thisWillFail();
    } catch (Exception e) {
        print("Caught the exception");
        e.printStackTrace();
    }
}

"Like Super Friends. But not really"
shared void theSuperTypes() {
    // The "Anything" type is the supertype of ALL other types, including Null
    Anything a1 = "abc";
    Anything a2 = null;

    // There are two subtypes of Anything: Object and Null:
    Object o1 = "abc";
    Anything a3 = o1;
    // Object o2 = null; // Compile error! null is not an Object

    Null n1 = null;
    Anything a4 = n1;
}

"They aren't that bad, I promise"
shared void genericFunctions() {
    // Generics in Ceylon are REIFIED!
    // This is the only JVM language with reified generics right now

    void foo<Element>(Element e1, Element e2)
            given Element satisfies Object { // To prevent nulls

        value elType = `Element`; // Try to do this in Java
        print("Typeof element = ``elType``, e1 = ``e1``, e2 = ``e1``");
    }

    foo(1, 4);
    foo("ABC", "DEF");
    foo(1, "DEF");
}