APP_NAME=faasex SECRET_KEY_BASE="$(mix phx.gen.secret)" MIX_ENV=prod DATABASE_URL="postgresql://postgres:postgres@localhost:5432/function_server_based_on_arweave_dev" PORT=4000 mix phx.server


postgresql://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa

APP_NAME=faasex SECRET_KEY_BASE="$(mix phx.gen.secret)" MIX_ENV=prod DATABASE_URL="postgresql://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa" PORT=4000 mix phx.server

APP_NAME=faasex SECRET_KEY_BASE="$(mix phx.gen.secret)" MIX_ENV=prod DATABASE_URL="postgresql://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa" PORT=4000 mix ecto.setup