PYTHON ?= $(shell test -x .env/bin/python && echo .env/bin/python || echo python)
PIP ?= $(PYTHON) -m pip
PYTEST ?= $(PYTHON) -m pytest
RUFF ?= $(PYTHON) -m ruff

.PHONY: install install-dev dev-setup test test-fast test-integration lint format clean check

install:
	$(PIP) install -e .

install-dev:
	$(PIP) install -e ".[testing,dev]"

dev-setup: install-dev
	$(PYTHON) tests/init_pyghidra.py

test:
	$(PYTEST)

test-fast:
	$(PYTEST) -m fast

test-integration:
	$(PYTEST) -m integration

lint:
	$(RUFF) check ghidriff tests

format:
	$(RUFF) format ghidriff tests

check: lint test-fast

clean:
	rm -rf build dist *.egg-info .pytest_cache .ruff_cache
	find ghidriff tests -type d -name __pycache__ -prune -exec rm -rf {} +
