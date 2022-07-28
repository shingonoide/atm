build:
	@docker compose build

console:
	@docker compose run --rm web rails console

test:
	@docker compose run --rm web rspec -f doc

up:
	@docker compose up

upd:
	@docker compose up -d

down:
	@docker compose down

shell:
	@docker compose run --rm web bash -l
