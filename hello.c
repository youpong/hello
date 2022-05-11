#include <stdio.h>
#include <stdlib.h>

#include <libintl.h>
#include <locale.h>

//#define LOCALEDIR "/usr/share/local/"
#define LOCALEDIR "/home/nakajimay/git/c/hello/locale"

int main() {
    setlocale(LC_ALL, "");
    bindtextdomain("hello", LOCALEDIR);
    textdomain("hello");

    printf(gettext("Hello World\n"));

    return EXIT_SUCCESS;
}
