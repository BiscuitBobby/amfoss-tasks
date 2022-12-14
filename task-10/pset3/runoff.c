#include <stdio.h>
#include <stdbool.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// Candidates have name and vote count
typedef struct
{
    char *name;
    int votes;
} candidate;

// Array of candidates
candidate candidates[MAX];

// Number of candidates
int candidate_count;

// Function prototypes
bool vote(char name[], int j);
void print_winner(void);
int search(char name[]);

int main(int argc, char *argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: runoff [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
    }

    int voter_count;
    printf("Number of voters: ");
    scanf("%i", &voter_count);

    // Loop over all voters
    for (int i = 0; i < voter_count; i++)
    {
        char name[10];
        for (int j = 1;j<=3;j++){
        printf("Vote rank %d: ",j);
        scanf("%s", name);
        // Check for invalid vote
        if (!vote(name, j))
        {
            printf("Invalid vote.\n");
        }}
    }

    // Display winner of election
    winner();
}

// Update vote totals given a new vote
bool vote(char name[],int j)
{
    for (int i = 0; i < candidate_count; i++)
    {
        if (strcmp(candidates[i].name, name) == 0)
        {
            candidates[i].votes+=1+(3-j);
            return true;
        }
    }

    return false;
}

// Print the winner (or winners) of the election
void winner(void)
{
    int prev = -1;
    int x;
    int id;

    for (int i = 0; i < candidate_count + 1; i++)
    {
        x = candidates[i].votes;
        if (x > prev)
        {
            id = i;
            prev = candidates[id].votes;
        }
    }

    printf("%s\n", candidates[id].name);
    return;
}
