CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =

TARGET = hello
LANGUAGES = ja fr

POTFILE = po/$(TARGET).pot
POFILES = $(addsuffix /$(TARGET).po, $(addprefix po/, $(LANGUAGES)))
MOFILES = $(addsuffix /LC_MESSAGES/$(TARGET).mo, $(addprefix locale/, $(LANGUAGES)))

.PHONY: all clean potfile pofiles mofiles

all: $(TARGET) $(POTFILE) $(MOFILES)

clean:
	rm -f $(TARGET) *.o $(MOFILES)

$(TARGET): $(TARGET).o
	$(CC) -o $@ $< $(LDFLAGS)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< 

potfile: $(POTFILE)

$(POTFILE): $(TARGET).c Makefile
	xgettext --keyword=_ --language=C --add-comments --sort-output -o $@ $^
	sed -i -e 's/\(Project-Id-Version\): PACKAGE VERSION/\1: Hello 1.0/' \
	       -e 's/\(Report-Msgid-Bugs-To\): /\1: youpong@cpan.org/' \
	       -e 's|\(Content-Type: text/plain\); charset=CHARSET|\1; charset=UTF-8|' $@

pofiles: $(POFILES)

po/%/$(TARGET).po: $(POTFILE)
	msgmerge --update $@ $<

mofiles: $(MOFILES)

locale/%/LC_MESSAGES/$(TARGET).mo: po/%/$(TARGET).po
	msgfmt --output-file=$@ $<

