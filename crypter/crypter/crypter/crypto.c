#include "crypto.h"
#include <stdio.h>
#include <string.h>

int getPositionForChar(char* searchPool, char searchedChar) {
	return (int) (strchr(searchPool, searchedChar) - searchPool);
}

int getPositionForKey(char searchedChar) {
	return getPositionForChar(KEY_CHARACTERS, searchedChar);
}

char encryptChar(char in, char key) {
	return CYPHER_CHARACTERS[getPositionForChar(MESSAGE_CHARACTERS, in) ^ getPositionForKey(key)];
}

char decryptChar(char in, char key) {
	return MESSAGE_CHARACTERS[getPositionForChar(CYPHER_CHARACTERS, in) ^ getPositionForKey(key)];
}

int checkString(char* allowedChars, const char* checkChars) {
	size_t checkingLength = strlen(checkChars);
	for (size_t i = 0; i < checkingLength; i++) {
		if (getPositionForChar(allowedChars, checkChars[i]) < 0) {
			return -1;
		}
	}
	return 0;
}

int loopForResult(char* key, const char* looper, char* result, size_t keyLength, size_t loopLength, char (*function)(char, char)) {
	for (size_t i = 0; i < loopLength; i++) {
		result[i] = function(looper[i], key[i%keyLength]);
		result[i + 1] = '\0';
	}
	return 0;
}

int preConditionCheck(KEY key, char* validPool, const char* toBeChecked) {
	if (strlen(key.chars) < 1) {
		fprintf(stderr, "Invalid key length!\n");
		return E_KEY_TOO_SHORT;
	} else if (checkString(KEY_CHARACTERS, key.chars) < 0) {
		fprintf(stderr, "Invalid key characters!\n");
		return E_KEY_ILLEGAL_CHAR;
	}
	else if (key.type != 1) {
		fprintf(stderr, "Invalid encryption type!\n");
		return -1;
	}
	else if (checkString(validPool, toBeChecked) < 0) {
		fprintf(stderr, "Invalid message or cipheredText!\n");
		return validPool == MESSAGE_CHARACTERS ? E_MESSAGE_ILLEGAL_CHAR : E_CYPHER_ILLEGAL_CHAR;
	}
	return 0;
}

int encrypt(KEY key, const char* input, char* output) {
	int condition = preConditionCheck(key, MESSAGE_CHARACTERS, input);
	return (condition != 0) ? condition : loopForResult(key.chars, input, output, strlen(key.chars), strlen(input), &encryptChar);
}

int decrypt(KEY key, const char * cypherText, char * output) {
	int condition = preConditionCheck(key, CYPHER_CHARACTERS, cypherText);
	return (condition != 0) ? condition : loopForResult(key.chars, cypherText, output, strlen(key.chars), strlen(cypherText), &decryptChar);
}
