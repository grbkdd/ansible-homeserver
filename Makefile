default: lint deps

lint:
	yamllint .
	ansible-lint

deps:
	ansible-galaxy role install -r requirements.yml -p .galaxy-roles
	ansible-galaxy collection install -r requirements.yml -p .galaxy-collections
