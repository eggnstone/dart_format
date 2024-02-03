class Tuple<T1, T2>
{
    final T1 item1;
    final T2 item2;

    const Tuple(this.item1, this.item2);

    @override
    String toString() => '($item1, $item2)';
}

class IntTuple extends Tuple<int, int>
{
    const IntTuple(super.item1, super.item2);

    const IntTuple.empty() : super(-1, -1);
}
