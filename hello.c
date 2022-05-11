#include <stdio.h>
#include <stdlib.h>

#include <libintl.h>
#include <locale.h>

int main(int argc, char** argv) {
    setlocale(LC_ALL, "");
    bindtextdomain("hello", "/usr/share/local/");
    textdomain("hello");

    printf(gettext("Hello World\n"));

    return EXIT_SUCCESS;
}
