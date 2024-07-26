import 'package:freezed_annotation/freezed_annotation.dart';

part 'Triple.freezed.dart';

@freezed
class Triple<T1, T2, T3> with _$Triple<T1, T2, T3>
{
    const factory Triple(
        T1 item1,
        T2 item2,
        T3 item3
    ) = _Triple<T1, T2, T3>;
}
