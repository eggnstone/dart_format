void f()
{
    return Scaffold(
        appBar: AppBar(
            actions: !userProtected.isAdmin ? null : <Widget>[
                ],
            actions: !userProtected.isAdmin ? null : <Widget>[
                    /*IconButton(
                    )*/
                ]
        )
    );
}
