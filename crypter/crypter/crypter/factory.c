#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include "crypto.h"
#include "factory.h"

void doFileStuff(char* mode, KEY key, char* path) {
	char buffer[255] = "";
	char info[255] = "";
	strcat(info, "Your ");strcat(info, mode);strcat(info, "ed Text:\n");
	fprintf(stdout, info);

	//read file
	FILE* data = fopen(path, "r");
	fgets(buffer, 255, data);
	fclose(data);

	int(*functionMode)(KEY, char*, char*);
	char result[255] = "";
	functionMode = (mode == "encrypt" ? &encrypt : &decrypt);
	functionMode(key, buffer, result);
	fprintf(stdout, result);
}

void doConsoleStuff(char* mode, KEY key) {
	char buffer[255] = "";
	fprintf(stdout, "Please put your text:\n");

	//read console
	fgets(buffer, 255, stdin);

	//removes trailing \n from buffer
	char *pos; if ((pos = strchr(buffer, '\n')) != NULL) *pos = '\0';
		
	int(*functionMode)(KEY, char*, char*);
	char result[255] = "";
	functionMode = (mode == "encrypt" ? &encrypt : &decrypt);
	functionMode(key, buffer, result);
	fprintf(stdout, result);
}

int main(int argc, char* argv[]) {
	// check args
	if (argc < 2) {
		fprintf(stderr, "Not enough arguments\n");
		return -1;
	}
	//argv[0] = "decrypt";
	KEY myKey = { .type = 1,.chars = argv[1] };
	if (argv[0] == "encrypt") {
		if (argc >= 3) { //File handling, ignores more than 3 args
			doFileStuff("encrypt", myKey, argv[2]);
		} else { //Console handling
			doConsoleStuff("encrypt", myKey);
		}
	} else if (argv[0] == "decrypt") {
		if (argc >= 3) { //File handling, ignores args after 3
			doFileStuff("decrypt", myKey, argv[2]);
		} else { //Console handling
			doConsoleStuff("decrypt", myKey);
		}
	} else {
		fprintf(stderr, "Wrong mode!\n");
		return -1;
	}
	return 0;
}
