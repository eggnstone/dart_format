class JsonTools
{
    static T get<T>(dynamic json, String key, T def)
    // ignore: avoid_dynamic_calls
    => json[key] as T? ?? def;

    static T getOrThrow<T>(dynamic json, String key)
    // ignore: avoid_dynamic_calls
    => json[key] as T;
}
