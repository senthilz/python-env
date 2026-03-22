# -------- Config --------
PYTHON_VERSION := $(shell cat .python-version 2>/dev/null || echo "3.14.3")

REQ := requirements.txt
REQ_DEV := requirements-dev.txt

# -------- Phony Targets --------
.PHONY: install install-dev update clean freeze check help

# -------- Install --------
install:
	@if [ -f $(REQ) ]; then \
		uv pip install -r $(REQ); \
	else \
		echo "No $(REQ) found"; \
	fi

install-dev:
	@if [ -f $(REQ_DEV) ]; then \
		uv pip install -r $(REQ_DEV); \
	else \
		echo "No $(REQ_DEV) found"; \
	fi

# -------- Update --------
update:
	@if [ -f $(REQ) ]; then \
		uv pip install --upgrade -r $(REQ); \
	fi

# -------- Maintenance --------
clean:
	@echo "Cleaning Python artifacts..."
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete
	@rm -rf .pytest_cache .mypy_cache .coverage htmlcov
	@rm -rf dist build *.egg-info

freeze:
	uv pip freeze > requirements.freeze.txt

check:
	uv pip check

# -------- UX --------
help:
	@echo "Available targets:"
	@echo "  make install       Install production dependencies"
	@echo "  make install-dev   Install development dependencies"
	@echo "  make update        Update dependencies"
	@echo "  make clean         Remove build/cache artifacts"
	@echo "  make freeze        Freeze current environment"
	@echo "  make check         Check dependency issues"
