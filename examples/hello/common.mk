###############
# Common part
###############
DEFAULT: all
BIN = bin
DMD = dmd
BASE_NAME = $(basename $(NAME))
NAME_TEST = $(BASE_NAME)-test 
DSCAN = $(D_DIR)/Dscanner/bin/dscanner
MKDIR = mkdir -p
RM = -rm -f
MODEL ?= $(shell getconf LONG_BIT)
DFLAGS += -m$(MODEL)

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

# Version flag
# use: make VERS=x
# -----------
VERSION_FLAG += $(if $(VERS), -version=$(VERS), )

.PHONY: all clean clobber test run pkg pkgsrc tags syn style loc var ver help

all: builddir $(BIN)/$(NAME)

builddir:
	@$(MKDIR) $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)

## se si usa unit_threaded
## make test T=nome_test
test: $(BIN)/$(NAME_TEST)
	@$(BIN)/$(NAME_TEST) $(T)

$(BIN)/$(NAME_TEST): $(SRC_TEST) $(LIB_TEST)| builddir
	$(DMD) $^ $(DFLAGS_TEST) $(INCLUDES_TEST) $(LDFLAGS) $(VERSION_FLAG) -of$@

pkgdir:
	$(MKDIR) pkg

pkg: $(PKG) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION).tar.bz2 $^
	zip pkg/$(BASE_NAME)-$(VERSION).zip $^

pkgsrc: $(PKG_SRC) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION)-src.tar.bz2 $^

tags: $(SRC)
	$(DSCAN) --ctags $^ > tags

style: $(SRC)
	$(DSCAN) --styleCheck $^

syn: $(SRC)
	$(DSCAN) --syntaxCheck $^

loc: $(SRC)
	$(DSCAN) --sloc $^

clean:
	$(RM) $(BIN)/*.o
	$(RM) $(BIN)/__*

clobber:
	$(RM) -f $(BIN)/*

ver:
	@echo $(VERSION)

var:
	@echo D_DIR:$(D_DIR)
	@echo SRC:$(SRC)
	@echo INCLUDES: $(INCLUDES)
	@echo LIB: $(LIB)
	@echo
	@echo DFLAGS: $(DFLAGS)
	@echo LDFLAGS: $(LDFLAGS)
	@echo VERSION: $(VERSION_FLAG)
	@echo
	@echo NAME_TEST: $(NAME_TEST)
	@echo SRC_TEST: $(SRC_TEST)
	@echo INCLUDES_TEST: $(INCLUDES_TEST)
	@echo LIB_TEST: $(LIB_TEST)
	@echo
	@echo T: $(T)


# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... test"
	@echo "... run"
	@echo "... clean"
	@echo "... clobber"
	@echo "... pkg"
	@echo "... pkgsrc"
	@echo "... tags"
	@echo "... style"
	@echo "... syn"
	@echo "... loc"
	@echo "... var"
