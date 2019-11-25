/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file is our header file for the memory interface
 *
 */

#ifndef MEMORY_H_
#define MEMORY_H_

// #include "instruct.h"
// #include "word.h"
#include <seq.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>


// typedef uint32_t word;

/* our memory struct */
typedef struct
{
    uint32_t registers[8];
    // uint32_t *mapped;
    Seq_T unmapped;
    int prog_counter;
} * Memory;

typedef struct 
{
    int length;
    uint32_t arr[];
} *Seg_T;

/**
 * This funciton will return a pointer to all of our necessary data for 
 * initializing the UM
 */
Memory init_um(FILE *input, int words);

/**
 * This funciton will run the program and incremene the prog_counter
 */
void run_program(Memory mem);


#endif