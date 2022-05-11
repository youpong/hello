CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =

TARGET = hello

.PHONY: all clean

all: $(TARGET) po/$(TARGET).pot locale/fr/LC_MESSAGES/$(TARGET).mo locale/ja/LC_MESSAGES/$(TARGET).mo

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $< $(LDFLAGS)

po/$(TARGET).pot: hello.c
	xgettext --keyword=_ --language=C --add-comments --sort-output -o $@ hello.c

locale/fr/LC_MESSAGES/$(TARGET).mo: po/fr/$(TARGET).po
	msgfmt --output-file=$@ $<

locale/ja/LC_MESSAGES/$(TARGET).mo: po/ja/$(TARGET).po
	msgfmt --output-file=$@ $<

clean:
	rm -f $(TARGET) locale/fr/LC_MESSAGES/*.mo locale/ja/LC_MESSAGES/*.mo
