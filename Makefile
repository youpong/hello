TARGET = hello
SRCS = $(TARGET).c
OBJS = $(SRCS:c=o)

LANGUAGES = ja fr
LOCALEDIR = locale
POTFILE = po/$(TARGET).pot
POFILES = $(addsuffix .po, $(addprefix po/, $(LANGUAGES)))
MOFILES = $(POFILES:%.po=%.mo)

CFLAGS = -Wall -Wextra -std=c17 -g
CPPFLAGS = -I.
LDFLAGS =
INSTALL = install

.PHONY: all build clean potfile pofiles mofiles
.PRECIOUS: po/%.po

all: $(TARGET) $(MOFILES)

build: all
	for lang in $(LANGUAGES); do \
		$(INSTALL) -D po/$$lang.mo $(LOCALEDIR)/$$lang/LC_MESSAGES/$(TARGET).mo ;\
	done

clean:
	rm -f  $(TARGET) $(OBJS) $(MOFILES)
	rm -rf $(LOCALEDIR)

$(TARGET): $(OBJS)
	$(CC) -o $@ $< $(LDFLAGS)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< 

potfile: $(POTFILE)
pofiles: $(POFILES)
mofiles: $(MOFILES)

$(POTFILE): $(SRCS) Makefile
	xgettext --keyword=_ --language=C --add-comments --sort-output --force-po -o $@ $^
	sed -i -e 's/\(Project-Id-Version\): PACKAGE VERSION/\1: Hello 1.0/' \
	       -e 's/\(Report-Msgid-Bugs-To\): /\1: youpong@cpan.org/' \
	       -e 's|\(Content-Type: text/plain\); charset=CHARSET|\1; charset=UTF-8|' $@

po/%.po: $(POTFILE)
	if [ ! -f $@ ]; then \
		msginit --input=$< --output=$@ --locale=$* --no-translator ; \
	else \
		msgmerge --update $@ $< ; \
	fi

%.mo: %.po
	msgfmt --output-file=$@ $<
