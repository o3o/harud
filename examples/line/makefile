NAME = line
VERSION = 0.1.0

ROOT_SOURCE_DIR = .

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")
SRC = $(getSources)

LIB += ../../bin/libharud.a
INCLUDES += -I../../src

DFLAGS += $(if $(IS_LIB), -lib, )
## -debug compile in debug code
DFLAGS += -debug
## -g add symbolic debug info
#DFLAGS += -g 
## -w  warnings as errors (compilation will halt)
DFLAGS += -w
DFLAGS += -m64
LDFLAGS = -L-lhpdf

VERSION_FLAG = $(if $(V), -version=$(V), )

DEFAULT: all

#################
BIN = .
DMD = dmd
BASE_NAME = $(basename $(NAME))
PDF = evince
.PHONY: all clean clobber run

all: builddir $(BIN)/$(NAME)

builddir:
	@mkdir -p $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)
	$(PDF) ./$(NAME).pdf

ps: $(NAME).ps

$(NAME).ps : $(NAME).pdf
	pdftops -paper A4 $^

$(NAME).pdf : all
	$(BIN)/$(NAME)

tags: $(SRC)
	$(DSCAN) --ctags -R src > tags

clean:
	-rm -f $(BIN)/*.o
	-rm -f $(BIN)/__*
	-rm -f $(BIN)/*.pdf

clobber:
	-rm -f $(BIN)/$(NAME)


var:
	@echo SRC:$(SRC)
	@echo INCLUDES: $(INCLUDES)
	@echo DFLAGS: $(DFLAGS)
	@echo LDFLAGS: $(LDFLAGS)
	@echo VERSION: $(VERSION_FLAG)
