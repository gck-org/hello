/*
 *   hello v1 - Greets you nicely
 *
 *   FEATURES:
 *       - Nice
 *       - Friendly
 *       - Useless
 *
 *   LIMITATIONS:
 *       - Platform: Only builds for POSIX systems
 *
 *   COMPILATION (Linux - POSIX):
 *       ./configure && make
 *
 *
 *   LICENSE: BSD-3-Clause
 *
 *   Copyright (c) 2025 GCK
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <config.h>
#include <stdio.h>
#include <stdlib.h>

#include "../lib/proginfo.h"

typedef enum { MIT, GPL, BSD, UNL } licence_t;

static int exit_status;

static void print_help(void);
static void print_version(void);

int main(int argc, char **argv)
{
	exit_status = EXIT_SUCCESS;
	set_prog_name(argv[0]);

	parse_standard_options(argc, argv, print_help, print_version);

	if (argc < 2)
		puts("Hello, World!");
	else {
		for (int i = 1; i < argc; ++i)
			printf("Hello, %s!\n", argv[i]);
	}

	return exit_status;
}

static void print_help(void)
{
	printf("Usage: %s [OPTION]...\n", PROGRAM);
	fputs("\
Greets you nicely.\n",
	      stdout);
	puts("");
	fputs("\
      --help                  display this help and exit\n\
      --version               display version information and exit\n",
	      stdout);
	exit(exit_status);
}

static void print_version(void)
{
	printf("%s %s %d\n", prog_name, VERSION, COMMIT);

	printf("Copyright (C) %d GCK.\n", YEAR);

	puts("This is free software: you are free to change and redistribute it.");
	puts("There is NO WARRANTY, to the extent permitted by law.");
	exit(exit_status);
}

/* end of file hello.c */
