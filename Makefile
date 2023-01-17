CC     = gcc
CFLAGS = -I $(IDIR) -g -Wall
IDIR   = inc
SOURCE = src
ODIR   = obj
LDIR   = lib
LIBS   = -lm
BUILDDIR = build
_DEPS  = ssd1306.h
DEPS   = $(patsubst %,$(IDIR)/%,$(_DEPS))
_OBJ   = main.o ssd1306.o ubuntuMono_8pt.o ubuntuMono_16pt.o ubuntuMono_24pt.o ubuntuMono_48pt.o
OBJ    = $(patsubst %,$(ODIR)/%,$(_OBJ))
PREFIX = /usr/local
SYSTEMD_UNIT_DIR = /lib/systemd/system

$(ODIR)/%.o: $(SOURCE)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(BUILDDIR)/oled12864: $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o $(BUILDDIR)/*~ core $(INCDIR)/*~ 

install:
	install -d $(PREFIX)/bin/
	install -m 644 ./build/oled12864 $(PREFIX)/bin/
	install -m 644 ./src/oled12864.service $(SYSTEMD_UNIT_DIR)