void f()
{
    switch (v)
    {
        default:
        break;
    }
}

// should be

/*
void f()
{
    switch (v)
    {
        default:
            break;
    }
}
*/
