
/*
   Your assignment:
   1) Pull down a JSON document from The Open Movie Database http://www.omdbapi.com/ by searching by title and possibly year
   2) Parse it into a Movie class (which you will define). Try to parse the fields intelligently.
   3) Print the movie facts to the screen in some way that looks readable
   4) Make sure that you handle the case of errors and searches returning no results

   Extra Credit: Use the ceylon.time module, or native Java 8 Date (JodaTime), to parse the dates in the JSON results

   Hints:
   * Use the included imports and skeleton as a good place to start
   * If you look at the module.ceylon for the workshop, you can see the names of the http and json modules, which
    will come in handy when Googling
*/

import ceylon.http.client { Request }
import ceylon.uri { parseUri = parse, Query, Parameter }
import ceylon.json { parseJson = parse, JsonObject }

String omdbUrl = "http://www.omdbapi.com/";

shared class Movie() {}

shared void run() {

    value searchResult = search("Ben-Hur", "1959");

    if (exists searchResult) {
        print("Movie: ``searchResult``");
    } else {
        print("That movie was not found");
    }

}

shared Movie|Null search(String title, String? year = null) {
    return null;
}

