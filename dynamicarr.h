#include <stdio.h>
#include <stdlib.h>

#ifndef DYNAMICARR_H_
#define DYNAMICARR_H_

typedef struct 
{  
    int load_val;
    int curr_len;   // length we'll be referencing 
    int full_len;  // length to consider for expansions
    int num_elem;  // number of current indices that have been used, unmapped or mapped
} *Holder;

Holder init_arr();

void put();

int length_arr();

void free_arr();

#endif