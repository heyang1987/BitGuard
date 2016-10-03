int foo(char a, int b, int c);
 
int main()
{ 
    int i, j;
    i=1;
    j=300; 
    foo(1, i, j);   
    return 0; 
}
int foo(char a, int b, int c)
{   
    int x, y, z;
    x=a+b;
    y=c-a;
    z=x+y;
    return z;
}

