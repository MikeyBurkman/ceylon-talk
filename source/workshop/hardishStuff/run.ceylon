
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
import ceylon.collection { ArrayList }

String omdbUrl = "http://www.omdbapi.com/";

shared class Movie(shared String title,
        shared String year,
        shared String rating,
        shared String releaseDate,
        shared String runtime,
        shared String[] genres,
        shared String director,
        shared String[] writers,
        shared String[] actors
        ) {

    string => "Title: ``title``
               Year: ``year``
               Director: ``director``
               Rating: ``rating``
               Released On: ``releaseDate``
               Runtime: ``runtime``
               Genres: ``genres``
               Written By: ``writers``
               Main Cast: ``actors``";
}

shared void run() {

    value searchResult = search("Ben-Hur", "1959");

    if (exists searchResult) {
        print("Movie: ``searchResult``");
    } else {
        print("That movie was not found");
    }

}

shared Movie|Null search(String title, String? year = null) {

    value parameters = ArrayList{ Parameter("t", title) };

    if (exists year) {
        parameters.add(Parameter("y", year));
    }

    value uri = parseUri(omdbUrl)
        .withQuery(Query ( *parameters ));

    value result = Request(uri).execute().contents;
    value json = parseJson(result);
    if (!is JsonObject json) {
        throw Exception("Got back some unexpected result: ``result``");
    }

    if (json.getString("Response") == "False") {
        value message = json.getStringOrNull("Error") else "<Unknown>";
        if (message == "Movie not found!") {
            return null;
        } else {
            throw Exception("Got back error response: ``message``");
        }
    }

    return parseMovie(json);
}

Movie parseMovie(JsonObject json) {
    return Movie {
        title = json.getString("Title");
        year = json.getString("Year");
        rating = json.getString("Rated");
        releaseDate = json.getString("Released");
        runtime = json.getString("Runtime");
        genres = splitString(json.getString("Genre"));
        director = json.getString("Director");
        writers = splitString(json.getString("Writer"));
        actors = splitString(json.getString("Actors"));
    };
}

String[] splitString(String s) {
    return s.split(','.equals)
        .map((s) => s.trimmed)
        .sequence();
}

