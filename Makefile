CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =

TARGET = hello

.PHONY: all clean

all: $(TARGET) locale/fr/LC_MESSAGES/$(TARGET).mo locale/ja/LC_MESSAGES/$(TARGET).mo

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $< $(LDFLAGS)

locale/fr/LC_MESSAGES/$(TARGET).mo: po/fr/$(TARGET).po
	msgfmt --output-file=$@ $<

locale/ja/LC_MESSAGES/$(TARGET).mo: po/ja/$(TARGET).po
	msgfmt --output-file=$@ $<

clean:
	rm -f $(TARGET) locale/fr/LC_MESSAGES/*.mo locale/ja/LC_MESSAGES/*.mo
