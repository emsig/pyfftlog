help:
	@echo "Commands:"
	@echo ""
	@echo "  install        install in editable mode"
	@echo "  dev-install    install in editable mode with dev requirements"
	@echo "  pytest         run the test suite and report coverage"
	@echo "  flake8         style check with flake8"
	@echo "  html           build docs (update existing)"
	@echo "  html-clean     build docs (new, removing any existing)"
	@echo "  preview        renders docs in Browser"
	@echo "  linkcheck      check all links in docs"
	@echo "  clean          clean up all generated files"
	@echo ""

install:
	python -m pip install -e .

dev-install:
	python -m pip install -e .[all]

.ONESHELL:
pytest:
	rm -rf .coverage htmlcov/ .pytest_cache/
	pytest --cov=pyfftlog --mpl
	coverage html

flake8:
	flake8 docs/conf.py pyfftlog/ tests/ examples/

html:
	cd docs && make html

html-clean:
	cd docs && rm -rf examples/* _build/ && make html

preview:
	xdg-open docs/_build/html/index.html

linkcheck:
	cd docs && make linkcheck

clean:
	python -m pip uninstall pyfftlog -y
	rm -rf build/ dist/ .eggs/ pyfftlog.egg-info/ pyfftlog/version.py  # build
	rm -rf */__pycache__/ */*/__pycache__/      # python cache
	rm -rf .coverage htmlcov/ .pytest_cache/    # tests and coverage
	rm -rf docs/_build/ docs/examples/*         # docs
	rm docs/sg_execution_times.rst
