CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =

TARGET = hello
OBJS = $(TARGET).o
LANGUAGES = ja fr

POTFILE = po/$(TARGET).pot
POFILES = $(addsuffix .po, $(addprefix po/, $(LANGUAGES)))
MOFILES = $(POFILES:%.po=%.mo)

.PHONY: all clean potfile pofiles mofiles
.PRECIOUS: po/%.po

all: $(TARGET) $(POTFILE) $(MOFILES)

clean:
	rm -f $(TARGET) $(OBJS) $(MOFILES)

$(TARGET): $(OBJS)
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

po/%.po: $(POTFILE)
	if [ ! -f $@ ]; then \
		msginit --input=$< --output=$@ --locale=$* --no-translator ; \
	else \
		msgmerge --update $@ $< ; \
	fi

mofiles: $(MOFILES)

%.mo: %.po
	msgfmt --output-file=$@ $<


