#include <stdio.h>

int main()
{
    signed int user_number;
    char user_char;
    int c;
    int result;
    int total_ones;
    
    printf("Welcome to the CountOnes program.\n");
    while (1) {
        total_ones = 0;
        printf("\nPlease enter a number: ");
        scanf ("%d", &user_number); 
        for (c = 31; c >= 0; c--) {
            result = user_number >> c;
            
            if (result & 1) {
                total_ones += 1;
            }
        }
        
        printf("The number of bits set is: %d\n", total_ones);
        printf("Continue (y/n)?: ");
        scanf (" %c", &user_char);
        if (user_char == 'n') {
            printf("Exiting");
            return 0;
        }
    }
}
