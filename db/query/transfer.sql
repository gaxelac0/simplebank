/*
CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT 'now()'
)
*/

-- name: CreateTransfer :one
INSERT INTO transfers (
    from_account_id,
    to_account_id,
    amount
) VALUES (
    $1, $2, $3
) RETURNING *;


-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

-- name: ListTransfers :many
SELECT * FROM transfers
ORDER BY id
LIMIT $1 
OFFSET $2;

-- name: UpdateTransfer :one
UPDATE transfers
SET amount = $1
WHERE id = $2
RETURNING *;

-- name: DeleteTransfer :exec
DELETE FROM transfers
WHERE id = $1;