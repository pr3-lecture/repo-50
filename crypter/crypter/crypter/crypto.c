#include "crypto.h"
#include <stdio.h>
#include <string.h>

int getPositionForChar(char* searchPool, char searchedChar) {
	return (int) (strchr(searchPool, searchedChar) - searchPool);
}

int getPositionForMessage(char searchedChar) {
	return getPositionForChar(MESSAGE_CHARACTERS, searchedChar);
}

int getPositionForKey(char searchedChar) {
	return getPositionForChar(KEY_CHARACTERS, searchedChar);
}

int getPositionForCipher(char searchedChar) {
	return getPositionForChar(CYPHER_CHARACTERS, searchedChar);
}

char getEncryptedChar(int searchedPosition) {
	return CYPHER_CHARACTERS[searchedPosition];
}

char getDecryptedChar(int searchedPosition) {
	return MESSAGE_CHARACTERS[searchedPosition];
}

char encryptChar(char in, char key) {
	return getEncryptedChar(getPositionForMessage(in) ^ getPositionForKey(key));
}

char decryptChar(char in, char key) {
	return getDecryptedChar(getPositionForCipher(in) ^ getPositionForKey(key));
}

int checkString(char* allowedChars, char* checkChars) {
	int checkingLength = strlen(checkChars);
	for (int i = 0; i < checkingLength; i++) {
		if (getPositionForChar(allowedChars, checkChars[i]) < 0) {
			return -1;
		}
	}
	return 0;
}

int encrypt(KEY key, const char * input, char * output) {
	if (checkString(KEY_CHARACTERS, key.chars) < 0) {
		fprintf(stderr, "Invalid key!\n");
		return -1;
	}
	else if (checkString(MESSAGE_CHARACTERS, input) < 0) {
		fprintf(stderr, "Invalid message!\n");
		return -1;
	}
	else if (key.type != 1) {
		fprintf(stderr, "Invalid encryption type!\n");
		return -1;
	}

	int keyLength = strlen(key.chars);
	int inputLength = strlen(input);
	for (size_t i = 0; i < inputLength; i++) {
		output[i] = encryptChar(input[i], key.chars[i%keyLength]);
		output[i + 1] = '\0';
	}
	return 0;
}

int decrypt(KEY key, const char * cypherText, char * output) {
	if (checkString(KEY_CHARACTERS, key.chars) < 0) {
		fprintf(stderr, "Invalid key!\n");
		return -1;
	}
	else if (checkString(CYPHER_CHARACTERS, cypherText) < 0) {
		fprintf(stderr, "Invalid message!\n");
		return -1;
	}
	else if (key.type != 1) {
		fprintf(stderr, "Invalid encryption type!\n");
		return -1;
	}

	int keyLength = strlen(key.chars);
	int cypherLength = strlen(cypherText);
	for (size_t i = 0; i < cypherLength; i++) {
		output[i] = decryptChar(cypherText[i], key.chars[i%keyLength]);
		output[i + 1] = '\0';
	}
	return 0;
}
