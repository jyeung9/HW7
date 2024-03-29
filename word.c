/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file contains our implementation for our word interface 
 *
 */

#include "word.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


static inline uint64_t shl(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                return 0;
        else
                return word << bits;
}

/*
 * shift R logical
 */
static inline uint64_t shr(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                return 0;
        else
                return word >> bits;
}

static inline uint64_t Bitpack_getu(uint64_t word, unsigned width, unsigned lsb)
{
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        /* different type of right shift */
        return shr(shl(word, 64 - hi),
                   64 - width); 
}

/**
 * return_instruct
 * 
 * Parameters:  uint32_t word/value to take from
 * Return:      the op code of the word (four most significant bits)
 * Purpose:     this will take in a word and return the instruction in it
 * CRE:         none
//  */
// word return_instruct(word value)
// {
//     word instruct;
//     instruct = Bitpack_getu(value, 4, 28);
//     return instruct;
// }

/** 
 * get_three_reg
 * 
 * Parameters:  uint32_t value (the word), uint32_t* ra, rb, and rc (registers)
 * Return:      void
 * Purpose:     will get the tags of the three registers of given word
 * CRE:         ra, rb, rc cannot be NULL
 */
// void get_three_reg(word value, word *ra, word *rb, word *rc)
// {
//     assert(ra != NULL && rb != NULL && rc != NULL);
    
//     *ra = Bitpack_getu(value, 3, 6); // width 3, lsb 6
//     *rb = Bitpack_getu(value, 3, 3);
//     *rc = Bitpack_getu(value, 3, 0);

//     return;
// }

/*
 *
 * get_load_val
 * 
 * Parameters:  uint32_t value (the word), uint32_t* ra (register to 
 *              load value into), uint32_t(value to load into register)
 * Return:      void
 * Purpose:     loads a value into a register, for given load value 
 *              OP instruction
 * CRE:         ra and val cannot be NULL
 */
void get_load_val(word value, word *ra, word *val)
{
    assert(ra != NULL && val != NULL);
    *ra = Bitpack_getu(value, 3, 25);
    *val = Bitpack_getu(value, 25, 0);
    return;
}