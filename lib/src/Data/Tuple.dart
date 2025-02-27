import 'package:freezed_annotation/freezed_annotation.dart';

part 'Tuple.freezed.dart';

@freezed
abstract class Tuple<T1, T2> with _$Tuple<T1, T2>
{
    const factory Tuple(
        T1 item1,
        T2 item2
    ) = _Tuple<T1, T2>;
}
