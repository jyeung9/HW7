/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file is our header file for our word interface 
 * 
 */

#ifndef WORD_H_
#define WORD_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint32_t word;

/**
 * Name: return_instruct
 * Does: will return the operation (the four most significant bits) in a word
 */
word return_instruct(word value);

/**
 * Name: get_three reg
 * Does: grabs the register values from the word and stores them into
 * correct position in registers array
 */
void get_three_reg(word value, word *ra, word *rb, word *rc);

/**
 * Name: get_load_val
 * Does: this loads a value into register; will get the necessary 
 *       register and value from the word
 */
void get_load_val(word value, word *ra, word *val);

#endif