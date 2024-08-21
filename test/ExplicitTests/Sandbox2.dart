//void f(){C\n.c()\n.c();}
//void f(){C\n..c();}
//void f(){C\n.c;}
//void f(){C.c((){});}
//class C\nwith M{}
//void f()\n{\nint i=g\n.a\n.b;\n}

void f()
{
    a
        .b(()
            {
            }
        );
}

void g()
{
    a
        .b(
            ()
            {
            }
        );
}

void f()
{
    a(()
        {
        }
    );
}

void g()
{
    a(
        ()
        {
        }
    );
}
