/* Copyright (C) GCK
 *
 * This file is part of hello
 *
 * This project and file is licenced under the BSD-3-Clause licence.
 * <https://opensource.org/license/bsd-3-clause>
 */

#include <stdio.h>
#include <stdlib.h>

#include "standard.h"

void usage(int status)
{
	printf("Usage: %s [OPTION]... [NAMES]...\n", PROGRAM);
	fputs("\
Print a friendly greeting.\n", stdout);
	puts("");
	fputs("\
--help        display this help and exit\n\
--version     display version information and exit\n", stdout);
}

int main(int argc, char **argv)
{
	if (argc < 2 && !argv[1])
		return puts("Hello, World!"), EXIT_SUCCESS;

	parse_standard_options(usage, argc, argv);

	for (int i = 1; i < argc; ++i)
		printf("Hello, %s!\n", argv[i]);

	return 0;
}
