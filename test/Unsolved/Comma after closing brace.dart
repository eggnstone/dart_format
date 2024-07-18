final Iterable<int> placeholderDigits = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map<int>(
    (int n)
    // ignore: prefer_expression_function_bodies
    {
        return 0;
    }

);
/*
final Iterable<int> placeholderDigits = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map<int>(
(int n)
// ignore: prefer_expression_function_bodies
{
return 0;
},
);
*/

class C
{
    final void Function() a;
    final int b;

    const C({required this.a, required this.b});
}

final C x = C(
    a: ()
    {
    }
    ,
    b: 0
);
/*
final x = C(
a: () {},
b: 0,
);
*/
