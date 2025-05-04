default: lint

lint:
	yamllint .
	ansible-lint
