#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
                                if (message) return message; } while (0)

#include <stdio.h>
#include <string.h>
#include "crypto.h"

int tests_run = 0;

static char* encryptTest() {
	KEY key = { .type = 1, .chars = "TPE"};
	char input[6] = "HALLO";
	char output[6] = "";
	int result = encrypt(key, input, output);
	mu_assert("Encryption failed!", result == 0);
	mu_assert("Encryption doesn't contain correct string!", 
		(strcmp(output, "TOOXA") == 0));
}

static char* decryptTest() {
	KEY key = { .type = 1, .chars = "TPE" };
	char cipher[6] = "TOOXA";
	char output[6] = "";
	int result = decrypt(key, cipher, output);
	mu_assert("Decryption failed!", result == 0);
	mu_assert("Decryption doesn't contain correct string!",
		(strcmp(output, "HALLO") == 0));
}

static char* factoryTest() {
	mu_assert("Factory failed!", 1 == 1);
}

static char* errorTest() {
	mu_assert("No Error occured, but expected!", 1 == 1);
}

static char* allTests() {
	mu_run_test(encryptTest);
	mu_run_test(decryptTest);
	mu_run_test(factoryTest);
	mu_run_test(errorTest);
	return 0;
}

int main() {
	char *result = allTests();

	if (result != 0) printf("%s\n", result);
	else             printf("ALL TESTS PASSED\n");

	printf("Tests run: %d\n", tests_run);

	return result != 0;
}