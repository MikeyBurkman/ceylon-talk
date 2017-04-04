
import org.joda.time { DateTime }

"Yes it really is this easy (most of the time)"
shared void useJodaTime() {
    value dt = DateTime(); // Call the constructor the Ceylon way
    print("Current time: ``dt``");
    
    value lastWeek = dt.minusDays(7); // Transparently use a Ceylon integer
    print("Last week: ``lastWeek.toString("MMM dd YYYY")``");

    // Named arguments not supported when calling Java stuff though. (Arg names not always available)
}

