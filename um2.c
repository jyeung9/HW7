/**
 * 
 * COMP40 
 * Fall 2019
 * HW: 6 -- The UM
 * Julie Yeung (jyeung03) and Zetty Cho (echo02)
 * 
 * This file contians our code for running our UM
 * We took the code for bitpacking from the reference provided by COMP40
 * 
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>

#define BYTESIZE 8

/* this struct represents a segment */
typedef struct 
{
    int length;
    uint32_t arr[];
} *Seg_T;

/* this array represents the registers */
uint32_t registers[BYTESIZE];
int prog_counter;

/* variables for the array of mapped segments */
Seg_T *MAPPED;
const float LOAD_VAL = 0.5;
float CURR_LEN;
float CAPACITY;

/* variables for the array of unmapped indices */
int *UNMAPPED;
float UCURR_LEN;
float UCAPACITY;

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
 * This funciton will return a pointer to all of our necessary data for 
 * initializing the UM
 */
static inline void init_um(FILE *input, int words);

/**
 * This funciton will run the program and incremene the prog_counter
 */
static inline void run_program();

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
static inline void map_segment(uint32_t *rb, uint32_t rc);

/**
 * Will unmap the specified segment and add th index to unmapped
 */
static inline void unmap_segment(uint32_t rc);

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
static inline void free_all();

/**
 * This function will contain all switch statements for the 
 * instructions
 */
static inline void execute_instruct(uint32_t code);

/*  From the Reference Bitpack Implementation 
 *  Logical Left Shift 
 */
static inline uint64_t shl(uint64_t word, unsigned bits)
{
        // assert(bits <= 64);
        if (bits > 64) {
            fprintf(stderr, "ERROR");
            exit(EXIT_FAILURE);
        }
        if (bits == 64)
            return 0;
        else
            return word << bits;
}

/*  From the Reference Bitpack Implementation 
 *  Logical Right Shift 
 */
static inline uint64_t shr(uint64_t word, unsigned bits)
{
        // assert(bits <= 64);
        if (bits > 64) {
            fprintf(stderr, "ERROR");
            exit(EXIT_FAILURE);
        }
        if (bits == 64)
            return 0;
        else
            return word >> bits;
}

/*  From the Reference Bitpack Implementation 
 *  Checks whether given value fits
 */
static inline bool Bitpack_fitsu(uint64_t n, unsigned width)
{
        if (width >= 64)
            return true;
        /* thanks to Jai Karve and John Bryan  */
        /* clever shortcut instead of 2 shifts */
        return shr(n, width) == 0; 
}

/*  From the Reference Bitpack Implementation 
 *  Retrieves a field from a given word
 */
static inline uint64_t Bitpack_getu(uint64_t word, unsigned width, unsigned lsb)
{
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        // assert(hi <= 64);
        if (hi > 64) {
            fprintf(stderr, "ERROR");
            exit(EXIT_FAILURE);
        }
        /* different type of right shift */
        return shr(shl(word, 64 - hi),
                   64 - width); 
}

/*  From the Reference Bitpack Implementation 
 *  Updates a field within a given word
 */
static inline uint64_t Bitpack_newu(uint64_t word, unsigned width, unsigned lsb,
                      uint64_t value)
{
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        if(hi > 64){
            fprintf(stderr, "ERROR\n");
            exit(EXIT_FAILURE);
        }
        // assert(hi <= 64);
        if (!Bitpack_fitsu(value, width))
            exit(EXIT_FAILURE);
            // assert(0);
        return shl(shr(word, hi), hi)                 /* high part */
            | shr(shl(word, 64 - lsb), 64 - lsb)  /* low part  */
            | (value << lsb);                     /* new part  */
}

/**
 *  Parameters
 *  Returns: 
 *  Purpose: returns number of words in file
 */
static inline int word_num(char *filename)
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
        fprintf(stderr, "Invalid format\nCorrect usage: \"./um [filename]\"\n");
        exit(EXIT_FAILURE);
    }

    FILE *input;
    char *filename = argv[1];
    input = fopen(filename, "r");

    /* checking if FILE * is valid */
    if (input != NULL) {
        init_um(input, word_num(filename));
        fclose(input);
        run_program();
    }
    else {
        fprintf(stderr, "Invalid format\nCorrect usage: \"./um [filename]\"\n");
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}

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
static inline void init_um(FILE *input, int words)
{
    if(input == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(input != NULL);
    /* will initialize registers and prog counter to 0 */
    prog_counter = 0;
    for (int i = 0; i < BYTESIZE; i++) {
        registers[i] = 0;
    }

    /* function to get length of file and return # of words */
    if(words <= 0){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    assert(words > 0);
    Seg_T seg = malloc(sizeof(*seg) + words * sizeof(uint32_t));
    if (seg == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(seg != NULL);
    seg->length = words;
    
    for (int i = 0; i < words; i++) { 
        uint32_t value = 0;
        for (int j = 24; j >= 0; j -= BYTESIZE) {
            int c = getc(input);
            value = Bitpack_newu(value, BYTESIZE, j, (uint32_t)c);
        }
        seg->arr[i] = value;
    }

    CAPACITY = 100000;
    CURR_LEN = 1;
    MAPPED = malloc(sizeof(Seg_T) * CAPACITY);
    assert(MAPPED != NULL);
    if(MAPPED == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    MAPPED[0] = seg;

    UCAPACITY = 100000;
    UCURR_LEN = 0;
    UNMAPPED = malloc(sizeof(int) * UCAPACITY);
    if (UNMAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(UNMAPPED != NULL);

}

/**
 * free_all
 * 
 * Parameters: Reference to the memory that needs to be freed.
 * Returns: Nothing
 * Purpose: Will free all memory associated with the struct used
 * CRE: Mem cannot be NULL
 */
static inline void free_all()
{
    if (UNMAPPED != NULL) {
        free(UNMAPPED);
    }
    if (MAPPED != NULL) {
        for (int i = 0; i < CURR_LEN; i++) {
            Seg_T temp = MAPPED[i];
            if (temp != NULL) {
                free(temp);
            }
        }
        free(MAPPED);
    }
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
static inline void run_program()
{
    while (true) {
        uint32_t instruct = MAPPED[0]->arr[prog_counter]; 
        execute_instruct(instruct);
        prog_counter++;
    }
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
static inline void execute_instruct(uint32_t instruction)
{
    uint32_t op_code = Bitpack_getu(instruction, 4, 28);
    uint32_t ra = 0;
    if (op_code == LV) {
        uint32_t value = Bitpack_getu(instruction, 25, 0);
        ra = Bitpack_getu(instruction, 3, 25);
        load_value(&(registers[ra]), value);
        return;
    }
    ra = Bitpack_getu(instruction, 3, 6);
    uint32_t rb = Bitpack_getu(instruction, 3, 3);
    uint32_t rc = Bitpack_getu(instruction, 3, 0);


    if (op_code == CMOV) {
        conditional_move(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if(op_code == SLOAD) {
        seg_load(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if (op_code == SSTORE) {
        seg_store(registers[ra], registers[rb], registers[rc]);
    }
    else if (op_code == ADD) {
        add(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if (op_code == MUL) {
        multiply(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if (op_code == DIV) {
        divide(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if (op_code == NAND) {
        bitwise_nand(&(registers[ra]), registers[rb], registers[rc]);
    }
    else if (op_code == HALT) {
        free_all();
        halt();
    }
    else if (op_code == OUT) {
        output(registers[rc]);
    }
    else if (op_code == IN) {
        input(&(registers[rc]));
    }
    else if (op_code == LOADP) {
        load_program(registers[rb], registers[rc], &(prog_counter));
    }
    else if (op_code == MAP) {
        map_segment(&(registers[rb]), registers[rc]);
    }
    else if (op_code == UNMAP) {
        unmap_segment(registers[rc]);
    }
    /*
    switch (op_code) {
    case CMOV:
        conditional_move(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case SLOAD:
        seg_load(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case SSTORE:
        seg_store(registers[ra], registers[rb], registers[rc]);
        break;
    case ADD:
        add(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case MUL:
        multiply(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case DIV:
        divide(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case NAND:
        bitwise_nand(&(registers[ra]), registers[rb], registers[rc]);
        break;
    case HALT:
        free_all();
        halt();
        break;
    case OUT:
        output(registers[rc]);
        break;
    case IN:
        input(&(registers[rc]));
        break;
    case LOADP:
        load_program(registers[rb], registers[rc], &(prog_counter));
        break;
    case MAP:
        map_segment(&(registers[rb]), registers[rc]);
        break;
    case UNMAP:
        unmap_segment(registers[rc]);
        break;
    }*/
}

/**
 * add
 * 
 * Parameters:  pointer to register ra, and values inside registers rb, rc
 * Return:      void
 * Purpose:     adds values in registers rb and rc, stores in register ra
 * CRE:         ra cannot be NULL
 */
static inline void add(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL); // would remove this
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
static inline void multiply(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL);
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
static inline void divide(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL);
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
static inline void bitwise_nand(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL);
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
static inline void load_value(uint32_t *ra, uint32_t val)
{
    // assert(ra != NULL);
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
static inline void halt()
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
static inline void map_segment(uint32_t *rb, uint32_t rc)
{
    // assert(rb != NULL)
    if(MAPPED == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(MAPPED != NULL);
    // assert(UNMAPPED != NULL);
    if (UNMAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    
    Seg_T temp = malloc(sizeof(*temp) + rc * sizeof(uint32_t));
    if (temp == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(temp != NULL);
    temp->length = rc;
    
    for (int i = 0; i < (int)rc; i++) {
        temp->arr[i] = 0;
    }
    if (UNMAPPED != NULL && UCURR_LEN > 0) {
        UCURR_LEN--;
        *rb = UNMAPPED[(int)UCURR_LEN];
        MAPPED[*rb] = temp;
    }
    else {
        *rb = CURR_LEN;
        MAPPED[*rb] = temp;
        CURR_LEN++;
        if ((CURR_LEN/CAPACITY) > LOAD_VAL) { /* have to expand */
            CAPACITY = CAPACITY * 2;
            Seg_T *temp = malloc(sizeof(Seg_T) * CAPACITY);
            // assert(temp != NULL);
            if(temp == NULL){
                fprintf(stderr, "ERROR\n");
                exit(EXIT_FAILURE);
            }
            for (int i = 0; i < CURR_LEN; i++) {
                temp[i] = MAPPED[i];
            }

            free(MAPPED);
            MAPPED = temp;
        }
    }
    return;
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
static inline void unmap_segment(uint32_t rc)
{
    // assert(MAPPED != NULL);
    if (MAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(UNMAPPED != NULL);
    if (UNMAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(MAPPED[rc] != NULL);
    if(MAPPED[rc] == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    free(MAPPED[rc]);
    MAPPED[rc] = NULL;
    
    /* TAKE CARE OF MAKING SURE NOT NULL OR SOMETHING, CHECK FOR -1 LENGTH*/

    UNMAPPED[(int)UCURR_LEN] = rc;
    UCURR_LEN++;
    if ((UCURR_LEN / UCAPACITY) > 0.5) {
        UCAPACITY = UCAPACITY * 2;
        int *temp = malloc(sizeof(int) * UCAPACITY);
        if (temp == NULL) {
            fprintf(stderr, "ERROR\n");
            exit(EXIT_FAILURE);
        }
        // assert(temp != NULL);
        for (int i = 0; i < UCURR_LEN; i++) {
            temp[i] = UNMAPPED[i];
        }
        free(UNMAPPED);
        UNMAPPED = temp;
    }
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
static inline void seg_load(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL);
    if(MAPPED == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(MAPPED != NULL);
    *ra = MAPPED[rb]->arr[rc];
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
static inline void seg_store(uint32_t ra, uint32_t rb, uint32_t rc)
{
    // assert(MAPPED != NULL);
    if (MAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    MAPPED[ra]->arr[rb] = rc; 
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
static inline void conditional_move(uint32_t *ra, uint32_t rb, uint32_t rc)
{
    // assert(ra != NULL);
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
static inline void load_program(uint32_t rb, uint32_t rc, int *count)
{
    if(count == NULL){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    // assert(count != NULL);
    // assert(MAPPED != NULL);
    if (MAPPED == NULL) {
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    
    if (rb != 0) {
        /* deep copy */
        int length = MAPPED[rb]->length;
        Seg_T store_here = malloc(sizeof(*store_here) + 
                                  length * sizeof(uint32_t));
        if (store_here == NULL) {
            fprintf(stderr, "ERROR\n");
            exit(EXIT_FAILURE);
        }
        // assert(store_here != NULL);
        store_here->length = length;
        for (int i = 0; i < length; i++) {
            store_here->arr[i] = MAPPED[rb]->arr[i];
        }
        free(MAPPED[0]); // will we need to assert that this is not NULL
         /****************** ASSERTION?   ***************************/
        MAPPED[0] = store_here;
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
static inline void input(uint32_t *rc)
{
    // assert(rc != NULL);
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
static inline void output(uint32_t rc)
{
    // assert(rc < 256);
    if(rc >= 256){
        fprintf(stderr, "ERROR\n");
        exit(EXIT_FAILURE);
    }
    putchar(rc);
    return;
}