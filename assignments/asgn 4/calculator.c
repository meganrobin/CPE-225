#include <stdio.h>
#include "operations.h"

int main()
{
    int ops = 0; /* create variable to hold total number of operations*/
    int result; /* create variable to hold result of operation*/
    signed int number1; /* create variable to hold first number*/
    signed int number2; /* create variable to hold second number*/
    int op_choice; /* create variable to hold user's choice of operation*/
    char user_char; /* create variable to hold user's choice of y or n*/

    printf("Welcome to the Calculator program.\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift\n");
    while (1) {
        printf("\nNumber of operations performed: %d", ops);
        printf("\nEnter number: ");
        scanf("%d", &number1);
        printf("Enter second number: ");
        scanf("%d", &number2);
        printf("Select operation: ");
        scanf("%d", &op_choice);
        
        if (op_choice == 1) {
            result = addnums(number1, number2);
        }
        else if (op_choice == 2) {
            result = subnums(number1, number2);
        }
        else if (op_choice == 3) {
            result = multnums(number1, number2);
        }
        else if (op_choice == 4) {
            result = divnums(number1, number2);
        }
        else if (op_choice == 5) {
            result = andnums(number1, number2);
        }
        else if (op_choice == 6) {
            result = ornums(number1, number2);
        }
        else if (op_choice == 7) {
            result = xornums(number1, number2);
        }
        else if (op_choice == 8) {
            result = lshiftnums(number1, number2);
        }
        else if (op_choice == 9) {
            result = rshiftnums(number1, number2);
        }
        else {
            printf("Invalid Operation \n");
        }
        
        printf("Result: %d\n", result);
        ops += 1;
        
        printf("Continue (y/n)?: ");
        scanf (" %c", &user_char);
        if (user_char == 'n') {
            printf("\nNumber of operations performed: %d\nExiting", ops);
            return 0;
        }
    }
}
