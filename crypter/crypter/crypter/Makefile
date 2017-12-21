.PHONY: all clean runtest
all: build
clean:
	rm -f decrypt encrypt tests crypto.o factory.o test.o tests.exe
test.o: test.c
	gcc -Wall -c test.c
crypto.o: crypto.c
	gcc -Wall -c crypto.c
factory.o: factory.c
	gcc -Wall -c factory.c
build: factory.o crypto.o
	gcc -o encrypt factory.o crypto.o
	gcc -o decrypt factory.o crypto.o
	runtest
runtest: test.o crypto.o
	gcc -o tests test.o crypto.o
	./tests