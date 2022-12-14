#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include<stdlib.h>

//use ./argv 'message' 'key' in the terminal
int main(int argc, char *argv[]) {
  // Check if the number of arguments
  if (argc != 3) {
    printf("Usage: %s string shift\n", argv[0]);
    return 1;
  }

  // Get the string and the key
  char *string = argv[1];
  int shift = atoi(argv[2]);

  if (shift < 0 || shift > 26) {
    printf("Error: shift must be in the range [0, 26]\n");
    return 1;
  }

  int len = strlen(string);
  char encrypted[len + 1];

  // Encrypt
  for (int i = 0; i < len; i++) {
    char c = string[i];
    if (isalpha(c)) {
      // Shift the letter
      c = toupper(c);
      c = ((c - 'A') + shift) % 26 + 'A';
    }
    encrypted[i] = c;
  }
  encrypted[len] = '\0';


  printf("Encrypted message: %s\n", encrypted);

  return 0;
}
