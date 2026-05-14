void f()
{
    if (true)
        ;
    else
    if (true)
        ;
}

/*
should be 

void f()
{
    if (true)
        ;
    else
        if (true)
            ;
}

 */
