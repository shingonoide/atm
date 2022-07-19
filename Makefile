build:
	@docker compose build

console:
	@docker compose run --rm web rails console

rspec:
	@docker compose run --rm web rspec -f doc

generate:
	@docker compose run --rm web rails g 
