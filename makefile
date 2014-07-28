NAME = libharud.a 
VERSION = 0.1.0
IS_LIB = true

ROOT_SOURCE_DIR = src

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")
#SRC = $(wildcard $(ROOT_SOURCE_DIR)/$(NAME)/*.d)
SRC = $(getSources) 

#LIB += $(D_DIR)/serial-port/libserial-port.a
#LIB += $(D_DIR)/dejector/libdejector.a
#LIB += $(D_DIR)/GtkD/libgtkd-2.a
#LIB += $(D_DIR)/SDLang-D/libsdlang-d.a
#LIB += $(D_DIR)/ddb/libddb.a

#INCLUDES += -I$(D_DIR)/dejector/source
#INCLUDES += -I$(D_DIR)/GtkD/src
#INCLUDES += -I$(D_DIR)/ddb/source
#INCLUDES += -I$(D_DIR)/SDLang-D/src

DFLAGS += $(if $(IS_LIB), -lib, )
## -debug compile in debug code
DFLAGS += -debug
## -g add symbolic debug info
#DFLAGS += -g 

## -w  warnings as errors (compilation will halt)
DFLAGS += -w

##-wi warnings as messages (compilation will continue)
DFLAGS += -wi

DFLAGS += -m64

LDFLAGS = -L-lhpdf 
## si usa make VERS=x
VERSION_FLAG = $(if $(VERS), -version=$(VERS), )

#################
# TEST 
#################

SRC_TEST = $(SRC)
#SRC_TEST = $(filter-out $(ROOT_SOURCE_DIR)/app.d, $(SRC)) 
#SRC_TEST += $(wildcard tests/*.d)

## oppure
#SRC_TEST = $(wildcard $(ROOT_SOURCE_DIR)/$(NAME)/*.d)
#SRC_TEST += $(wildcard tests/*.d)

LIB_TEST += $(LIB)
#LIB_TEST =  $(D_DIR)/dunit/libdunit.a
#LIB_TEST += $(D_DIR)/DMocks-revived/libdmocks-revived.a
#LIB_TEST += $(D_DIR)/unit-threaded/libunit-threaded.a

INCLUDES_TEST += $(INCLUDES)
#INCLUDES_TEST += -I$(D_DIR)/dunit/source
#INCLUDES_TEST += -I$(D_DIR)/DMocks-revived
#INCLUDES_TEST += -I$(D_DIR)/unit-threaded/source

DFLAGS_TEST += -unittest
# DFLAGS_TEST += -main -quiet

PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile

DEFAULT: all

#################
BIN = bin
DMD = dmd
BASE_NAME = $(basename $(NAME))
TEST_NAME = $(BASE_NAME)-test 
DSCAN = ~/dscanner
.PHONY: all clean clobber test run

all: builddir $(BIN)/$(NAME)

builddir:
	@mkdir -p $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)

## se si usa unit_threaded
## make test T=nome_test
test: $(BIN)/$(TEST_NAME)
	@$(BIN)/$(TEST_NAME) $(T)

$(BIN)/$(TEST_NAME): $(SRC_TEST) $(LIB_TEST)| builddir
	$(DMD) $^ $(DFLAGS_TEST) $(INCLUDES_TEST) $(LDFLAGS) $(VERSION_FLAG) -of$@

pkgdir:
	@mkdir -p pkg

pkg: $(PKG) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION).tar.bz2 $^
	zip pkg/$(BASE_NAME)-$(VERSION).zip $^

pkgsrc: $(PKG_SRC) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION)-src.tar.bz2 $^

tags: $(SRC)
	$(DSCAN) --ctags -R src > tags

style:
	$(DSCAN) --styleCheck -R src/

clean:
	-rm -f $(BIN)/*.o
	-rm -f $(BIN)/__*

clobber:
	-rm -f $(BIN)/*

var:
	@echo SRC:$(SRC)
	@echo INCLUDES: $(INCLUDES)
	@echo DFLAGS: $(DFLAGS)
	@echo LDFLAGS: $(LDFLAGS)
	@echo VERSION: $(VERSION_FLAG)
	@echo
	@echo SRC_TEST: $(SRC_TEST)
	@echo INCLUDES_TEST: $(INCLUDES_TEST)
