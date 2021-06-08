SHELL := /bin/bash

VENV = ./.venv

APP_STAGE = dev

.PHONY: activate
activate: ## activates the virtual env and if it doesn't exist creates one in .venv/
ifneq (,$(wildcard $(VENV)))
	source $(VENV)/bin/activate
else
	python3 -m venv $(VENV) && source $(VENV)/bin/activate
endif

.PHONY: build
build: install-requirements package ## runs a full build (installs all the dependencies, creates SAM template)

.PHONY: install-requirements
install-requirements: activate
		pip install -r requirements.txt

.PHONY: package
package: ## creates AWS Serverless Application Model (SAM) template
	chalice package /tmp/packaged --stage $(APP_STAGE)
