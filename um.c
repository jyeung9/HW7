/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file contians our code for running our UM
 * 
 */

#include "word.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <except.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "memory.h"

static Except_T Invalid_Format = 
                    {"Invalid format\nCorrect usage: \"./um [filename]\"\n"};


/**
 * This function will return the number of words in the file
 */
static int word_num(char *filename)
{
    struct stat st;
    stat(filename, &st);
    int size = st.st_size; // returns size in bytes
    int words = size / 4;
    return words;
}

int main(int argc, char **argv)
{
   
    /* checking where to get input from */
    if (argc > 2 || argc < 2) {
        RAISE(Invalid_Format);
        exit(EXIT_FAILURE);
    }

    FILE *input;

    char *filename = argv[1];
    input = fopen(filename, "r");

    /* checking if FILE * is valid */
    if (input != NULL) {
        Memory mem = init_um(input, word_num(filename));
        fclose(input);
        run_program(mem);
    }
    else {
        RAISE(Invalid_Format);
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}

