import ceylon.json {
    JsonObject,
    parse
}

shared void jsonTest() {
    value json = "{ \"x\": 10.0, \"y\": 10E1 }";
    value o = parse(json);
    assert (is JsonObject o );
    Float x = o.getFloat("x");
    Float y = o.getFloat("y"); // Fails here
}