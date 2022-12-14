#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main() {
  // Get the string
  char string[100];
  printf("Enter a string: ");
  fgets(string, sizeof(string), stdin);

  // Initialize the counters
  int letters = 0;
  int words = 0;
  int sentences = 0;

  // Count the number of letters, words, and sentences in the string
  int len = strlen(string);
  for (int i = 0; i < len; i++) {
    if (isalpha(string[i])) {
      letters++;
    }
    if (isspace(string[i])) {
      words++;
    }
      int len = strlen(string);
  }

  for (int i = 0; i < len; i++) {
    if (string[i] == '.' || string[i] == '!' || string[i] == '?') {
      sentences++;
    }
  }

  // Print the results
  printf("Letters: %d\n", letters);
  printf("Words: %d\n", words + 1);
  printf("Sentences: %d\n", sentences);
  float L = (letters / words) * 100;
  float S = (sentences / words) * 100;
  float index = 0.0588 * L - 0.296 * S - 15.8;
  int x = index;
  if (index<16){
  printf("grade - %d\n",(x));
  }
  else{printf("grade - 16+");}
  return 0;
}
//letters / words * 100