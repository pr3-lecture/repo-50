.PHONY: all clean runtest
all: build
clean:
	rm -f decrypt encrypt tests crypto.o main.o test.o tests.exe
test.o: test.c
	gcc -Wall -c test.c
crypto.o: crypto.c
	gcc -Wall -c crypto.c
main.o: main.c
	gcc -Wall -c main.c
build: main.o crypto.o
	gcc -o encrypt main.o crypto.o
	gcc -o decrypt main.o crypto.o
	runtest
runtest: test.o crypto.o
	gcc -o tests test.o crypto.o
	./tests