postgres:
	docker run -d -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -p 5432:5432 --name postgres14 postgres:14-alpine

consolepg:
	docker exec -it postgres14 psql simple_bank

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres14 dropdb simple_bank

migrateup:
	migrate --path db/migration/ --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate --path db/migration/ --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb postgres consolepg migrateup migratedown