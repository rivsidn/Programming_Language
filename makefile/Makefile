
var := $(shell echo "aaa")

CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
	  else if [ -x /bin/bash ]; then echo /bin/bash; \
	  else echo sh; fi ; fi)

all:
	@echo ${var}
	@echo ${CONFIG_SHELL}


