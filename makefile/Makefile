
BASH := ./NIHAO

#SHELL := $(shell echo $$BASH)

CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
	  else if [ -x /bin/bash ]; then echo /bin/bash; \
	  else echo sh; fi ; fi)

all:
	@echo ${CONFIG_SHELL}

