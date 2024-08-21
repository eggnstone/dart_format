void h()
{
    assert(renderBoxDoingDryBaseline == null,
    'RenderBox.size accessed in '
    '${objectRuntimeType(renderBoxDoingDryBaseline, 'RenderBox')}.computeDryBaseline.'
    'The computeDryBaseline method must not access '
    '${renderBoxDoingDryBaseline == this ? "the RenderBox's own size" : "the size of its child"},'
    "because it's established in peformLayout or peformResize using different BoxConstraints."
    );
}
