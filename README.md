# Ceylon Talk/Workshop
A quick crash course in Ceylon

## What is Ceylon?
* Ceylon is a new(ish) programming language (2011)
* Developed by Red Hat and other companies, designed primarily by Gavin King (of Hibernate and CDI fame in the Java world)
* Completely open souce (of course), all hosted on Github
* Aimed particularly at larger enterprise-scale projects with multiple team members
* Designed by specification first, with the implementation coming second
* Compiles to both JVM and JavaScript

### Design Goals
* Type safety -- It *will* reduce the number of runtime exceptions you will see
* Consistency in the language -- Fewer obscure rules to remember
* Immutability by default (related to type safety)
* Source code reability -- prefer more-verbose English over obscure symbols
* Effective tooling -- IDE plugins developed side-by-side with the language, not as an afterthought
* Straight-forward interop with existing libraries (either Java or JavaScript)
* Modularity -- Not everything needs to be public

## Important Links
* [Ceylon Main Site](https://ceylon-lang.org/)
* [Ceylon Tour](https://ceylon-lang.org/documentation/1.3/tour/) -- Like this talk, only better (and a lot longer)
* [Ceylon FAQ](https://ceylon-lang.org/documentation/1.3/faq/) -- Contains answers to questions everyone has, such as "Why another language?"
* [Ceylon Language Design FAQ](https://ceylon-lang.org/documentation/1.3/faq/language-design/) -- Contains answers to questions regarding the design choices in the language, such as why semicolons are required
* [Ceylon Download](https://ceylon-lang.org/download/)
* [Ceylon Source](http://ceylon.github.io/)

## What's not covered in this?
Lots of things. The language, though relatively new, contains a vast number of features, which we just don't have time to go over. All of these are described quite well in the Ceylon Tour above. 

Some things I'll be glancing over or skipping entirely:
* Named constructors and advanced class initialization
* Anonymous classes
* Comprehensions (as made famous by Python)
* Type aliases
* Intersection types -- These are a bit less common in everyday use, but are important for understanding how the compiler reasons about some things
* Modularity in packages and modules
* JS Interop
* Annotations and metamodel/reflection
* Threading/parallelism -- Not part of the language, and depends on the VM that Ceylon is running on
