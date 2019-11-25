/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file contains our implementation for the memory interface
 *
 */

#include "memory.h"
// #include "segment.h"
// #include "instruct.h"
#include <assert.h>
#include <except.h>
#include <um-dis.h>
#include <sys/stat.h>
#include <stdbool.h>

#define BYTESIZE 8

const float LOAD_VAL = 0.5;
float CURR_LEN;   // length we'll be referencing 
float FULL_LEN;  // length to consider for expansions (capacity)
Seg_T *ARR;

typedef enum Um_opcode
{
    CMOV = 0,
    SLOAD,
    SSTORE,
    ADD,
    MUL,
    DIV,
    NAND,
    HALT,
    MAP,
    UNMAP,
    OUT,
    IN,
    LOADP,
    LV
} Um_opcode;

/**
 * this takes the values from registers rb and rc and puts the sum in ra
 */
static inline void add(uint32_t *ra, uint32_t rb, uint32_t rc);

/**
 * this takes the values from registers rb and rc and puts the product % 2^32
 * in ra
 */
static inline void multiply(uint32_t *ra, uint32_t rb, uint32_t rc);

/**
 * this takes the values from registers rb and rc and puts the quotient in ra
 */
static inline void divide(uint32_t *ra, uint32_t rb, uint32_t rc);

/**
 * this performs a bitwise AND on registers rb and rc, then 
 * derives the complement of that result, and stores that complement
 * into register ra
*/
static inline void bitwise_nand(uint32_t *ra, uint32_t rb, uint32_t rc);

/** 
 * this will take the value specified and input it into register ra
 */
static inline void load_value(uint32_t *ra, uint32_t val);

/**
 * this takes the word at word offset rc, and segment at segment rb
 * and puts it into register ra
 */
static inline void seg_load(uint32_t *ra, uint32_t rb, uint32_t rc);

/**
 * Will create a new segment with the specified length and store the address
 * in register rb
 */
static inline void map_segment(uint32_t *rb, uint32_t rc, Seq_T unmapped);

/**
 * Will unmap the specified segment and add th index to unmapped
 */
static inline void unmap_segment(uint32_t rc, Seq_T unmapped);

/**
 * Will take the word located in register rc and store in mapped[ra][rb]
 */
static inline void seg_store(uint32_t ra, uint32_t rb, uint32_t rc);

/**
 * If rc != 0, the value in ra = rb
 */
static inline void conditional_move(uint32_t *ra, uint32_t rb, uint32_t rc);

/**
 * The segment at rb in mapped is duplicated and set into mapped[0]
 */
static inline void load_program(uint32_t rb, uint32_t rc, int *count);

/**
 * reads in the user input and stores in register rc
 */
static inline void input(uint32_t *rc);

/**
 * takes the value in register rc and prints out
 */
static inline void output(uint32_t rc);

/**
 * ends the program
 */
static inline void halt();

/**
 * This function will ensure all the data from the memory struct is properly
 * freed
 */
static inline void free_all(Memory mem);

/**
 * This function will contain all switch statements for the 
 * instructions
 */
static inline void execute_instruct(Memory mem, uint32_t code);

Except_T Bitpack_Overflow = { "Overflow packing bits" };

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


static inline bool Bitpack_fitsu(uint64_t n, unsigned width)
{
        if (width >= 64)
                return true;
        /* thanks to Jai Karve and John Bryan  */
        /* clever shortcut instead of 2 shifts */
        return shr(n, width) == 0; 
}

static inline uint64_t Bitpack_getu(uint64_t word, unsigned width, unsigned lsb)
{
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        /* different type of right shift */
        return shr(shl(word, 64 - hi),
                   64 - width); 
}

static inline uint64_t Bitpack_newu(uint64_t word, unsigned width, unsigned lsb,
                      uint64_t value)
{
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        if (!Bitpack_fitsu(value, width))
                RAISE(Bitpack_Overflow);
        return shl(shr(word, hi), hi)                 /* high part */
                | shr(shl(word, 64 - lsb), 64 - lsb)  /* low part  */
                | (value << lsb);                     /* new part  */
}

static inline void init_arr(Seg_T seg);

static inline void append_arr(Seg_T segment);

static inline void expand();

static inline void free_arr();


/** 
 * init_um
 * 
 * Parameters: Takes in a pointer to a memory struct that contains our memory,
 *              registers and prog_counter. Also takes in file to read in 
 *              instructions from
 * Returns:     Nothing
 * Purpose:     This will initialize all of the memory-storing data types for 
 *              running our UM
 * CRE:         The input file cannot be NULL, the formed segment cant be NULL
 */
Memory init_um(FILE *input, int words)
{
    // fprintf(stderr, "beginning initializatins\n");
    assert(input != NULL);
    Memory mem;
    mem = malloc(sizeof(*mem));
    assert(mem != NULL);
    /* will initialize registers and prog counter to 0 */
    mem->prog_counter = 0;
    for (int i = 0; i < BYTESIZE; i++) {
        mem->registers[i] = 0;
    }
    mem->unmapped = Seq_new(3);

    /* function to get length of file and return # of words */

    assert(words > 0);


    Seg_T seg = malloc(sizeof(*seg) + words * sizeof(uint32_t));
    assert(seg != NULL);
    seg->length = words;
    // Seg_new(words); /* initializing the segment to be inserted */
    
    
    for (int i = 0; i < words; i++) { // keep track of sets of bytes
        uint32_t value = 0;
        for (int j = 24; j >= 0; j -= BYTESIZE) {
            int c = getc(input);
            value = Bitpack_newu(value, BYTESIZE, j, (uint32_t)c);
        }
        // fprintf(stderr, "done bitpacking word %x\n", value);
        seg->arr[i] = value;
    }

    // fprintf(stderr, "length is %d\n",seg->length);
    /* this adds the first element to the mapped sequence */
    // mem->mapped = init_arr();   // initialize dynamic array
    // fprintf(stderr, "after making mapped\n");
    // Seg_T temp = (Seg_T)Seq_addhi(mem->mapped, seg);
    // (void)temp;

    // mem->mapped
    // fprintf(stderr, "ending initialization\n");
    init_arr(seg);
    
    return mem;
}

void init_arr(Seg_T seg)
{
    CURR_LEN = 1;
    FULL_LEN = 100000;
    ARR = malloc(sizeof(Seg_T) * FULL_LEN);
    ARR[0] = seg;
}




/**
 * free_all
 * 
 * Parameters: Reference to the memory that needs to be freed.
 * Returns: Nothing
 * Purpose: Will free all memory associated with the struct used
 * CRE: Mem cannot be NULL
 */
static void free_all(Memory mem)
{
    // fprintf(stderr, "in free all\n");
    assert(mem != NULL);
    if (mem->unmapped != NULL) {
        Seq_free(&(mem->unmapped));
    }

    if (ARR != NULL) {
        /* need code for freeing ARR */
        free_arr();
    }

    free(mem);
}

/** 
 * run_program
 * 
 * Parameters: Reference to the memory that contains the instructions
 * Returns: Nothing
 * Purpose: This will go through each word and execute the necessary
 *          instruction. Will increment the prog counter here
 * CRE: mem cannot be NULL
 */
void run_program(Memory mem)
{
    assert(mem != NULL);
    while (true) {
     
        uint32_t instruct = ARR[0]->arr[mem->prog_counter];
        execute_instruct(mem, instruct);
        mem->prog_counter++;
    }
    //fprintf(stderr, "ended running!\n");
}

/**
 * execute_instruct
 * 
 * Parameters: Reference to the memory that contains the instructions and the 
 *              current instruction
 * Returns: Nothing
 * Purpose: Will call the corresponding switch statement depending on the
 *          instruction. Will only change the prog_counter if the instruction
 *          specifies it
 * CRE: mem cannot be NULL
 */
static void execute_instruct(Memory mem, uint32_t instruction)
{
    // fprintf(stderr, "in execute instructions\n");
    assert(mem != NULL);
    uint32_t op_code = Bitpack_getu(instruction, 4, 28);
    // fprintf(stderr, "instruction: %u\n", op_code);
    uint32_t ra = 0;
    if (op_code == LV) {
        uint32_t value = Bitpack_getu(instruction, 25, 0);
        ra = Bitpack_getu(instruction, 3, 25);
        // get_load_val(instruction, &ra, &value);
        load_value(&(mem->registers[ra]), value);
        return;
    }
    ra = Bitpack_getu(instruction, 3, 6);
    uint32_t rb = Bitpack_getu(instruction, 3, 3);
    uint32_t rc = Bitpack_getu(instruction, 3, 0);
    // get_three_reg(instruction, &ra, &rb, &rc);
    switch (op_code) {
    case CMOV:
        conditional_move(&(mem->registers[ra]), mem->registers[rb],
                         mem->registers[rc]);
        break;
    case SLOAD:
        seg_load(&(mem->registers[ra]), mem->registers[rb],
                 mem->registers[rc]);
        break;
    case SSTORE:
        seg_store(mem->registers[ra], mem->registers[rb],
                  mem->registers[rc]);
        break;
    case ADD:
        add(&(mem->registers[ra]), mem->registers[rb],
            mem->registers[rc]);
        break;
    case MUL:
        multiply(&(mem->registers[ra]), mem->registers[rb],
                 mem->registers[rc]);
        break;
    case DIV:
        divide(&(mem->registers[ra]), mem->registers[rb],
               mem->registers[rc]);
        break;
    case NAND:
        bitwise_nand(&(mem->registers[ra]), mem->registers[rb],
                     mem->registers[rc]);
        break;
    case HALT:
        free_all(mem);
        halt();
        break;
    case OUT:
        output(mem->registers[rc]);
        break;
    case IN:
        input(&(mem->registers[rc]));
        break;
    case LOADP:
        load_program(mem->registers[rb], mem->registers[rc],
                     &(mem->prog_counter));
        break;
    case MAP:
        map_segment(&(mem->registers[rb]), mem->registers[rc], 
                    mem->unmapped);
        break;
    case UNMAP:
        unmap_segment(mem->registers[rc], mem->unmapped);
        break;
    }
}

#define BYTESIZE 8

/**
 * add
 * 
 * Parameters:  pointer to register ra, and values inside registers rb, rc
 * Return:      void
 * Purpose:     adds values in registers rb and rc, stores in register ra
 * CRE:         ra cannot be NULL
 */
void add(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    *ra = rb + rc;
    return;
}

/**
 * multiply
 * 
 * Parameters:  pointer to register ra, and values inside registers rb, rc
 * Return:      void
 * Purpose:     multiplies values in registers rb and rc, stores in register ra
 * CRE:         ra should not be NULL
 */
void multiply(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    *ra = rb * rc;
    return;
}

/**
 * divide
 * 
 * Parameters:  pointer to register ra, and values inside registers rb, rc
 * Return:      void
 * Purpose:     multiplies values in registers rb and rc, stores in register ra
 * CRE:         ra should not be NULL
 */
void divide(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    *ra = rb / rc;
    return;
}

/**
 * bitwise_nand
 * 
 * Parameters:  pointer to register ra, and values inside registers rb, rc
 * Return:      void
 * Purpose:     performs bitwise nand on rb and rc, stores result in ra
 * CRE:         ra should not be NULL
 */
void bitwise_nand(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    uint32_t and_result;
    and_result = rb & rc;
    *ra = (uint32_t)(~(and_result));
    return;
}

/**
 * load_val
 * 
 * Parameters:  pointer to register ra and values to be stored
 * Return:      void
 * Purpose:     adds values in registers rb and rc, stores in register ra
 * CRE:         ra should not be NULL
 */
void load_value(uint32_t *ra, uint32_t val)
{
    assert(ra != NULL);
    *ra = val;
    return;
}

/**
 * halt
 * 
 * Parameters:  none
 * Return:      void
 * Purpose:     stops computation, exits program
 * CRE:         none
 */
void halt()
{
    exit(0);
}

/**
 * map_segment
 * 
 * Parameters:  Register to store length and new address of segment, 
 *              references to unmapped indices and mapped segments
 * Return:      void
 * Purpose:     Will create a new mapped segment of all 0s. 
 * CRE:         rb should not be NULL, sequesnces should not be NULL
 */
void map_segment(uint32_t *rb, uint32_t rc, Seq_T unmapped)
{
    assert(rb != NULL);
    assert(ARR != NULL);
    assert(unmapped != NULL);
    
    Seg_T temp = malloc(sizeof(*temp) + rc * sizeof(uint32_t));
    assert(temp != NULL);
    temp->length = rc;
    
    // Seg_new(rc);
    for (int i = 0; i < (int)rc; i++) {
        temp->arr[i] = 0;
    }
    if (unmapped != NULL && Seq_length(unmapped) > 0) {
        *rb = (uint32_t)(uintptr_t)Seq_remlo(unmapped); 
        free(ARR[*rb]);
        ARR[*rb] = temp;
        // Seq_put(mapped, *rb, temp);
    }
    else {
        *rb = CURR_LEN;
        append_arr(temp);       // the add function, to end of array
        // *rb = Seq_length(mapped);
        // Seq_addhi(mapped, temp);
    }
  

    return;
}

void append_arr(Seg_T segment)
{
    // ARR[(int)CURR_LEN] = malloc(sizeof(*segment));
    ARR[(int)CURR_LEN] = segment;
    CURR_LEN++;
    if ((CURR_LEN / 2.0) > LOAD_VAL) {
        expand();
    }
    // have to check load val
}

void expand()
{
    FULL_LEN  = FULL_LEN * 2;   // new, expanded capacity
    Seg_T *temp = malloc(sizeof(Seg_T) * FULL_LEN);
    fprintf(stderr, "after *temp malloc\n");
    /* need to deep copy data, bc Seg_T is a pointer */
    fprintf(stderr, "b4 sizeof temp arr: %ld\n", sizeof(temp));
    for (int i  = 0; i < CURR_LEN; i++) {
        // fprintf(stderr, "sizeof(temp[i]): %ld\n", sizeof(temp[i]));
        // fprintf(stderr, "sizeof(ARR[i]): %ld\n", sizeof(ARR[i]));
        temp[i] = ARR[i];
        //fprintf(stderr, "ARR[i]->length: %d\n", (ARR[i]->length));
        //fprintf(stderr, "the whole shebang: %ld\n", sizeof(ARR[i]) + sizeof(uint32_t) * (ARR[i]->length));

        // temp[i] = malloc(sizeof(ARR[i]) + sizeof(uint32_t) * (ARR[i]->length));
        
        // temp[i]->length = ARR[i]->length;
        // for (int j = 0; j < temp[i]->length; j++) {
        //     // temp[i]->arr = malloc(sizeof(uint32_t) * (ARR[i]->length));
        //     temp[i]->arr[j] = ARR[i]->arr[j];
        // }
    }
    // fprintf(stderr, "sizeof temp arr: %ld\n", sizeof(temp));
    
    // free_arr(ARR);
    free(ARR);
    ARR = temp;
}

void free_arr()
{
    fprintf(stderr, "in free_arr\n");
    for(int i = 0; i < CURR_LEN; i++){
        free(ARR[i]);
    }
    free(ARR);
}

/**
 * unmap_segment
 * 
 * Parameters:  Register to store length and new address of segment, 
 *              references to unmapped indices and mapped segments
 * Return:      void
 * Purpose:     Will unmap a segment, append that to the end of the unmapped
 *              sequence. 
 * CRE:         mapped and unmapped should not be NULL
 */
void unmap_segment(uint32_t rc, Seq_T unmapped)
{
  
    assert(ARR != NULL);
    assert(unmapped != NULL);
    assert(ARR[rc]->length > 0);
    ARR[rc]->length = -1;
    
    
    /* TAKE CARE OF MAKING SURE NOT NULL OR SOMETHING, CHECK FOR -1 LENGTH*/

    // Seq_put(mapped, rc, NULL);
    void *temp = Seq_addhi(unmapped, (void *)(uintptr_t)rc);
    (void)temp;
    return;
}

/**
 * seg_load
 * 
 * Parameters:  pointer to register ra, index of segment and word within 
 *              segment
 * Return:      void
 * Purpose:     loads word from memory into register ra
 * CRE:         ra and mapped should not be NULL
 */
void seg_load(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    assert(ARR != NULL);
    *ra = ARR[rb]->arr[rc];
    // *ra = ((Seg_T)Seq_get(mapped, rb))->arr[rc];
    // Seg_get(Seq_get(mapped, rb), rc); // will change this to just indexing array
    return;
}

/**
 * seg_store
 * 
 * Parameters:  registers that store indexing of where to store and register 
 *              that holds word to be stored, mapped sequences
 * Return:      void
 * Purpose:     stores the value in rc into segment mapped[ra], word [rb].
 *              Will fail if out of bounds in any way
 * CRE:         mapped should not be NULL,  failure is there
 */
void seg_store(uint32_t ra, uint32_t rb, uint32_t rc)
{
    assert(ARR != NULL);
    
    ARR[ra]->arr[rb] = rc;
    // ((Seg_T)(Seq_get(mapped, ra)))->arr[rb] = rc; 
    return;
}

/**
 * conditional_move
 * 
 * Parameters:  register to compare with 0, register to load data from, register
 *              to load data into
 * Return:      void
 * Purpose:     if the value at rc is not 0, the value at rb will be stored into
 *              the value pointed to by ra. 
 * CRE:         ra should not be NULL
 */
void conditional_move(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    assert(ra != NULL);
    if (rc != 0) {
        *ra = rb;
    }
    return;
}

/**
 * load_program
 * 
 * Parameters:  The mapped sequence and the index to get the segment from,
 *              and the new prog counter
 * Return:      void
 * Purpose:     It will take the segment located at mapped[rb], duplicate it 
 *              and store the duplicate in mapped[0], can break when its out of
 *              bounds
 * CRE:         mapped and count should not be NULL, but can break
 */
void load_program(uint32_t rb, uint32_t rc, int *count)
{
    assert(count != NULL);
    assert(ARR != NULL && ARR[rb]->length > 0);
    
    if (rb != 0) {
        
        /* deep copy */
        int length = ARR[rb]->length;
        Seg_T store_here = malloc(sizeof(*store_here) + length * sizeof(uint32_t));
        // Seg_T store_here = ARR[rb];
        assert(store_here != NULL);
        // store_here->length = length;
        
        // Seg_new(length);
        for (int i = 0; i < length; i++) {
            store_here->arr[i] = ARR[rb]->arr[i];
        }

        Seg_T temp = ARR[0];
        ARR[0] = store_here;
        free(temp);
        // free(Seq_get(mapped, 0)); // will we need to assert that this is not NULL




        /****************** NOTE   ***************************/


        // Seq_put(mapped, 0, store_here);
     
    }
    *count = rc - 1;
    return;
}

/**
 * input
 * 
 * Parameters:  the register to store the value in
 * Return:      void
 * Purpose:     It will take in user input and put it into the specified reg
 * CRE:         rc should not be NULL
 */
void input(uint32_t *rc)
{
    assert(rc != NULL);
    int user_in = getchar();
    if (user_in == EOF) {
        *rc = (uint32_t)(~0);
    }
    else {
        *rc = (uint32_t)user_in;
    }
    return;
}

/**
 * output
 * 
 * Parameters:  the register to get the value from
 * Return:      void
 * Purpose:     It will take the value from reg rc and print it out
 * CRE:         rc is greater than 255
 */
void output(uint32_t rc)
{
    assert(rc < 256);
    putchar(rc);
    return;
}
