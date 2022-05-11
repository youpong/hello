#include <stdio.h>
#include <stdlib.h>

#include <libintl.h>
#include <locale.h>

//#define LOCALEDIR "/usr/share/local/"
#define LOCALEDIR "/home/nakajimay/git/c/hello/locale"

#define _(STRING) gettext(STRING)

int main() {
    setlocale(LC_ALL, "");
    bindtextdomain("hello", LOCALEDIR);
    textdomain("hello");

    printf(_("Hello World!\n"));

    return EXIT_SUCCESS;
}
