TARGET = hello

.PHONY: all clean

all: $(TARGET)

clean:
	rm -f $(TARGET)
