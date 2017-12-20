#include "crypto.h"
#include <stdio.h>
#include <string.h>

int getPositionForChar(char* searchPool, char searchedChar) {
	int poolLength = strlen(searchPool);
	for (size_t i = 0; i < poolLength; i++) {
		if (searchPool[i] == searchedChar) {
			return i;
		}
	}
	return -1;
}

int getPositionForMessage(char searchedChar) {
	int result = getPositionForChar(MESSAGE_CHARACTERS, searchedChar);
	if (result < 0) {
		return E_MESSAGE_ILLEGAL_CHAR;
	}
	else {
		return result;
	}
}

int getPositionForKey(char searchedChar) {
	int result = getPositionForChar(KEY_CHARACTERS, searchedChar);
	if (result < 0) {
		return E_KEY_ILLEGAL_CHAR;
	}
	else {
		return result;
	}
}

char getEncryptedChar(int searchedPosition) {
	int poolLength = strlen(CYPHER_CHARACTERS);
	char* pool = CYPHER_CHARACTERS;
	for (size_t i = 0; i < poolLength; i++) {
		if (i == searchedPosition) {
			return pool[i];
		}
	}
	return E_CYPHER_ILLEGAL_CHAR;
}

char encryptChar(char in, char key) {
	unsigned int resultInt = getPositionForMessage(in) ^ getPositionForKey(key);
	return getEncryptedChar(resultInt);
}

int encrypt(KEY key, const char * input, char * output) {
	int keyLength = strlen(key.chars);
	int inputLength = strlen(input);
	for (size_t i = 0; i < inputLength; i++) {
		output[i] = encryptChar(input[i], key.chars[i%keyLength]);
		output[i + 1] = "\0";
	}
	return 0;
}

int decrypt(KEY key, const char * cypherText, char * output) {
	return 0;
}
