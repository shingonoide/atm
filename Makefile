build:
	@docker compose build

console:
	@docker compose run --rm web rails console

rspec:
	@docker compose run --rm web rspec -f doc

generate:
	@docker compose run --rm web rails g ${args}

up:
	@docker compose up

upd:
	@docker compose up -d

down:
	@docker compose down

rails:
	@docker compose run --rm --tty web rails $@