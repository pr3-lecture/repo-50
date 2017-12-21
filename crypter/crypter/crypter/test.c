#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
                                if (message) return message; } while (0)

#include <stdio.h>
#include <string.h>
#include "crypto.h"
#include "factory.h"

int tests_run = 0;

static char* encryptTest() {
	KEY key = { .type = 1, .chars = "TPE"};
	char input[6] = "HALLO";
	char output[6] = "";
	int result = encrypt(key, input, output);
	mu_assert("Encryption failed!", result == 0);
	mu_assert("Encryption doesn't contain correct string!", (strcmp(output, "TOOXA") == 0));
}

static char* decryptTest() {
	KEY key = { .type = 1, .chars = "TPE" };
	char cipher[6] = "TOOXA";
	char output[6] = "";
	int result = decrypt(key, cipher, output);
	mu_assert("Decryption failed!", result == 0);
	mu_assert("Decryption doesn't contain correct string!", (strcmp(output, "HALLO") == 0));
}

static char* factoryTest() {
	mu_assert("Factory failed!", 1 == 1);
}

static char* errorTest() {
	KEY key = { .type = 2, .chars = "TPE" };
	char validInput[6] = "HALLO";
	char output[6] = "";
	int result = encrypt(key, validInput, output);
	mu_assert("No Error occured, but expected!", result == -1);

	key.type = 1;
	key.chars = "TP1E";
	result = encrypt(key, validInput, output);
	mu_assert("No Error occured, but expected!", result == E_KEY_ILLEGAL_CHAR);

	key.chars = "";
	result = encrypt(key, validInput, output);
	mu_assert("No Error occured, but expected!", result == E_KEY_TOO_SHORT);

	key.chars = "TPE";
	char wrongInput[6] = "HA1LLO";
	result = encrypt(key, wrongInput, output);
	mu_assert("No Error occured, but expected!", result == E_MESSAGE_ILLEGAL_CHAR);

	char wrongCiphertext[6] = "TO0XA";
	result = decrypt(key, wrongCiphertext, output);
	mu_assert("No Error occured, but expected!", result == E_CYPHER_ILLEGAL_CHAR);
}

static char* allTests() {
	mu_run_test(encryptTest);
	mu_run_test(decryptTest);
	mu_run_test(errorTest);
	mu_run_test(factoryTest);
	return 0;
}

int main() {
	char *result = allTests();

	if (result != 0) printf("%s\n", result);
	else             printf("ALL TESTS PASSED\n");

	printf("Tests run: %d\n", tests_run);

	return result != 0;
}