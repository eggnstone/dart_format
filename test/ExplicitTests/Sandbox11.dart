void f()
{
    return Scaffold(
        appBar: AppBar(
            actions: !userProtected.isAdmin1 ? null : <Widget>[
                ],
            actions: !userProtected.isAdmin2 ? null : <Widget>[
                    /*IconButton(
                    )*/
                ]
        )
    );
}

/*
should be

void f()
{
    return Scaffold(
        appBar: AppBar(
            actions: !userProtected.isAdmin1 ? null : <Widget>[
            ],
            actions: !userProtected.isAdmin2 ? null : <Widget>[
                /*IconButton(
                )*/
            ]
        )
    );
}
*/
