# Makefile for personal-utils

# Emacs invocation
EMACS_COMMAND   := emacs

# Use -q to have /usr/local/share/emacs/site-lisp and subdirs in load-path 
EMACS		:= $(EMACS_COMMAND) -q -batch
EVAL := $(EMACS) --eval
PKGDIR := .
# Additional emacs loadpath
LOADPATH	:= -L $(PKGDIR)
ELPA_DIR        =  $(HOME)/.emacs.d/elpa
ASYNC_ELPA_DIR  =  $(shell \
	test -d $(ELPA_DIR) && \
	find -L $(ELPA_DIR) -maxdepth 1 -regex '.*/async-[.0-9]*' 2> /dev/null | \
	sort | tail -n 1)
ifneq "$(ASYNC_ELPA_DIR)" ""
	LOADPATH += -L $(ASYNC_ELPA_DIR)
endif

# Files to compile
EL			:= $(sort $(wildcard personal-utils*.el))
# Compiled files
ELC			:= $(EL:.el=.elc)

.PHONY: clean autoloads batch-compile

all: clean autoloads batch-compile

$(ELC): %.elc: %.el
	$(EMACS) $(LOADPATH) -f batch-byte-compile $<

# Compile needed files
compile: $(ELC)

# Compile all files at once
batch-compile:
	$(EMACS) $(LOADPATH) -f batch-byte-compile $(EL)

# Remove all generated files
clean:
	rm -f $(ELC)

# Make autoloads file
autoloads:
	$(EVAL) "(let ((generated-autoload-file (expand-file-name \"personal-utils-autoloads.el\" \"$(PKGDIR)\")) \
(backup-inhibited t)) (update-directory-autoloads \"$(PKGDIR)\"))"
