class SimpleStack
{
    final String stack;

    SimpleStack(String name) : stack = name;

    SimpleStack add(String name)
    => SimpleStack('$stack/$name');

    @override
    String toString() 
    => stack;
}
