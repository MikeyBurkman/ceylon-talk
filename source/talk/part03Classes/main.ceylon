
// Simplest form of classes, made to hold immutable data
shared void basicDataClasses() {

    // Just like functions, classes can be declared virtually anywhere
    class Foo(shared Integer x, shared String s) {} // yep that's it

    // Constructors are regular functions -- no "new" keyword needed!
    value foo = Foo(42, "Adams");
    print("Foo = ``foo.x``; ``foo.s``");

    // Because constructors are regular functions, you can even get references to them
    value fooFactory = Foo;
    value foo2 = fooFactory(1, "abc");

    // These fields are IMMUTABLE
    // foo.x = 11; // Compile error!

    // To do private fields, leave out "shared".
    class Bar(Integer x) {
        shared String stuff() {
            return "Bar: ``x``";
        }
    }
    value bar = Bar(4);
    // bar.x; // Compile error -- not visible
    print("bar.stuff() = ``bar.stuff()``");

    // Since constructors are functions, they can be called in cool ways as well
    value foo3 = Foo {
        x = 99;
        s = "racecar";
    };
    print("Foo created with named args: ``foo3``");

    // Fun fact -- Ceylon encourages this technique to easily create type-safe config declarations.
    // No more error-prone xml configs!
}

"Though I'm still quite uncultured"
shared void refinement() {

    // All objects have defaults values for (to)string, equals, and hash(code), but they can
    //  of course be overridden:
    class Foo(shared Integer x, shared String s) {

        // "string" is the equivalent of Java's toString()
        // However, string is actually an ATTRIBUTE, not a function
        shared actual String string {
            return "Foo(``x``, ``s``)";
        }

        // Pretty much the same as Java
        shared actual Boolean equals(Object that) {
            if (is Foo that) {
                return x==that.x &&
                s==that.s;
            }
            else {
                return false;
            }
        }

        // Like string, hash is also an attribute, not a function
        shared actual Integer hash {
            variable value hash = 1;
            hash = 31*hash + x;
            hash = 31*hash + s.hash;
            return hash;
        }

        "Adds a new function to Foo"
        shared Foo withX(Integer newX) {
            return Foo(newX, s);
        }

        "Functions can also be expressions"
        shared Foo withS(String newS) => Foo(x, newS);

    }

    Foo bf1 = Foo(1, "test");
    value bf2 = bf1.withX(42);
    print("bf2.x = ``bf2.x``");

    // Refined members like string and equals() can be abbreviated as expressions
    class Bar(Integer x, String s) {
        string => "Bar(``x``, ``s``)";
    }

    print("Bar(4, a) = ``Bar(4, "a")``");

    // Function references to methods on classes
    value withX = bf1.withX;
    value bf3 = withX(22);
    print("bf3 = ``bf3``");
}

"Unlike Java"
shared void methodOverloading() {
    // Method can NOT be overloaded in Ceylon!
    // Should not be an issue with union types, default args, etc
    class Foo(shared Integer x) {
        shared void stuff(Integer|Float y) {
            if (is Integer y) {
                print("Integer -- adding: ``x + y``");
            } else {
                print("Float -- multiplying: ``x * y``");
            }
        }
    }

    value foo = Foo(10);
    foo.stuff(5);
    foo.stuff(3.0);

    // But why???
    // Simple reason -- easy to get references to the methods
    value stuff = foo.stuff;
    stuff(5);
    stuff(3.0);

    // This lets us easily pass methods around and compose them as first-class functions
    void callThisThing(Anything(Integer) fnToCall) {
        fnToCall(50);
    }

    callThisThing(foo.stuff);
}

"Build yer own abstractions"
shared void interfaces() {
    // Fairly similar to Java 8+ interfaces
    // (Can have attributes and even private functions, but no state)
    interface AwesomeThing {
        shared formal void howAwesome();
        shared default void printAwesome() => print("Awesome!");
    }

    class Hamburger(Boolean hasCheese) satisfies AwesomeThing {
        shared actual void howAwesome() {
            for (value i in 1..3) {
                printAwesome();
            }
        }
    }

    value burger1 = Hamburger(true);
    burger1.howAwesome();

    // Extending classes
    // Specify the constructor (usually) at the top!
    // Can not override anything in the subclass unless it's formal or default
    class AnchovyBurger() extends Hamburger(false) {
        shared actual void printAwesome() => print("Not Awesome");
    }

    value burger2 = AnchovyBurger();
    burger2.howAwesome();

}

"Classy basic classes"
shared void classSuperTypes() {
    // Classes by default satisfy Basic, not Object.
    // Basic is a subtype of Object, and implements default Equals() and hash
    class Foo(String x) {}
    Basic b1 = Foo("abc");
    print("b1.hash = ``b1.hash``");

    // We can extend Object() directly if we wish, but then we
    //  MUST implement Equals() and hash in order to compile!"
    class ObjectSubtype(String x) extends Object() {
        shared actual Boolean equals(Object that) {
            return that == this;
        }

        shared actual Integer hash => x.hash;
    }
    Object o1 = ObjectSubtype("abc");
    print("o1.hash = ``o1.hash``");
}

"Much like Java, but different"
shared void genericsInClasses() {

    class Box<Element>(Element contents) {
        string => "Box(``contents else "null"``)";
        shared Element myContents => contents;
    }

    value b1 = Box(42);
    Integer x = b1.myContents;
    print("Box1 = ``b1``");

    // Note that my Box is invariant -- I can't cast it to a more general box
    // Box<Object> b2 = b1; // Compile error

    // To fix that, we need...
}

"Ok this part can be confusing"
shared void varianceInGenericClasses() {
    // Covariance indicates what a generic collection is spitting out
    // In Java, this was usually <? extends Something>
    // In Ceylon, we annotate it with "out" (which is much simpler most of the time)

    class Box<out Element>(shared Element contents) {}

    value b1 = Box(42);
    Integer x = b1.contents;

    Box<Object> b2 = b1; // Now it's valid!

    // Note that it doesn't go the other way
    // Box<Integer> b3 = b2; // Compile error! Cannot cast Box<Object> to Box<Integer>


}