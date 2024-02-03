import 'Exceptions/DartFormatException.dart';

class StringBufferEx
{
    final StringBuffer _stringBuffer = StringBuffer();
    String _lastText1;
    String _lastText2;

    String get lastText => _lastText2 + _lastText1;

    StringBufferEx({String lastText = ''}) :
        _lastText1 = lastText,
        _lastText2 = '';

    void write(Object? o)
    {
        if (o == null)
            return;

        if (o is String)
        {
            _stringBuffer.write(o);
            _lastText2 = _lastText1;
            _lastText1 = o;
            return;
        }

        if (o is StringBufferEx)
        {
            _stringBuffer.write(o);
            _lastText1 = o._lastText1;
            _lastText2 = o._lastText2;
            return;
        }

        throw DartFormatException.error('Unsupported type: ${o.runtimeType}');
    }

    @override
    String toString()
    => _stringBuffer.toString();
}
