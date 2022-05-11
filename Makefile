CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =

TARGET = hello
LANGUAGES = ja fr

.PHONY: all clean pot pofiles

all: $(TARGET) po/$(TARGET).pot locale/fr/LC_MESSAGES/$(TARGET).mo locale/ja/LC_MESSAGES/$(TARGET).mo

$(TARGET): $(TARGET).o
	$(CC) -o $@ $< $(LDFLAGS)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< 

pot: po/$(TARGET).pot

po/$(TARGET).pot: hello.c Makefile
	xgettext --keyword=_ --language=C --add-comments --sort-output -o $@ $^
	sed -i -e 's/\(Project-Id-Version\): PACKAGE VERSION/\1: Hello 1.0/' \
	       -e 's/\(Report-Msgid-Bugs-To\): /\1: youpong@cpan.org/' \
	       -e 's|\(Content-Type: text/plain\); charset=CHARSET|\1; charset=UTF-8|' $@

pofiles: $(addsuffix /$(TARGET).po, $(addprefix po/, $(LANGUAGES)))

po/fr/$(TARGET).po: po/$(TARGET).pot
	msgmerge --update $@ $<

po/ja/$(TARGET).po: po/$(TARGET).pot
	msgmerge --update $@ $<

locale/fr/LC_MESSAGES/$(TARGET).mo: po/fr/$(TARGET).po
	msgfmt --output-file=$@ $<

locale/ja/LC_MESSAGES/$(TARGET).mo: po/ja/$(TARGET).po
	msgfmt --output-file=$@ $<

clean:
	rm -f $(TARGET) *.o locale/fr/LC_MESSAGES/*.mo locale/ja/LC_MESSAGES/*.mo

