// Addition with long
#include <stdio.h>
#include <cs50.h>

int main(void)
{
    // Prompt user for x
    long x = get_long("x: ");

    // Prompt user for y
    long y = get_long("y: ");

    // Perform addition
    printf("%ld\n", x + y);
    return 0;
}