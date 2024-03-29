#
# Makefile for the UM Test lab
# 
CC = gcc -O2

IFLAGS  = -I/comp/40/build/include -I/usr/sup/cii40/include/cii
CFLAGS  = -g -std=gnu99 -Wall -Wextra -Werror -pedantic $(IFLAGS)
LDFLAGS = -g -L/comp/40/build/lib -L/usr/sup/cii40/lib64
LDLIBS  = -l40locality -lcii40-O2 -lm -lbitpack -lum-dis -lcii
#LDLIBS  = -l40locality -lcii40 -lm -lbitpack -lum-dis -lcii

EXECS   = um

all: $(EXECS)

um: um.o 
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)

# To get *any* .o file, compile its .c file with the following rule.
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(EXECS)  *.o

