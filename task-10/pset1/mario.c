#include <stdio.h>

int main(void)
{printf("enter Height:");
int h;
scanf("%d",&h);
if (h<1 || h>8){
while (h<1 || h>8){printf("enter Height:");scanf("%d",&h);}
}
    for (int i = 0; i <= h; i++)
    {
        for (int k = (h-i); k > 0; k--){
            printf(" ");}
        for (int j = 0; j < i; j++)
        {
            printf("#");
        }
        printf(" ");
        for (int j = 0; j < i; j++)
        {
            printf("#");
        }
        printf("\n");
    }
}