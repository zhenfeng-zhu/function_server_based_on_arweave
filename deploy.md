1. 

prod.exs

```elixir
config :function_server_based_on_arweave, FunctionServerBasedOnArweaveWeb.Endpoint,
  http: [port: {:system, "PORT"}], # Possibly not needed, but doesn't hurt
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443],
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true,
  check_origin: false

config :function_server_based_on_arweave, FunctionServerBasedOnArweave.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: false,
  pool_size: 2 # Free tier db only allows 4 connections. Rolling deploys need pool_size*(n+1) connections where n is the number of app replicas.

```

2. 

```sh
❯ APP_NAME=$(gigalixir create -n faasex)                          
Created app: faasex.
Set git remote: gigalixir.

❯ gigalixir apps         
[
  {
    "cloud": "gcp",
    "region": "v2018-us-central1",
    "replicas": 0,
    "size": 0.3,
    "stack": "gigalixir-20",
    "unique_name": "faasex",
    "version": 2
  }
]

❯ git remote -v        
gigalixir       https://git.gigalixir.com/faasex.git/ (fetch)
gigalixir       https://git.gigalixir.com/faasex.git/ (push)
origin  https://github.com/zhenfeng-zhu/function_server_based_on_arweave.git (fetch)
origin  https://github.com/zhenfeng-zhu/function_server_based_on_arweave.git (push)
upstream        https://github.com/WeLightProject/function_server_based_on_arweave.git (fetch)
upstream        https://github.com/WeLightProject/function_server_based_on_arweave.git (push)

❯ gigalixir pg:create --free
A word of caution: Free tier databases are not suitable for production and migrating from a free db to a standard db is not trivial. Do you wish to continue? [y/N]: y
{
  "app_name": "faasex",
  "database": "bb39a8f2-2dd0-4149-b54c-d33832627cfa",
  "host": "postgres-free-tier-v2020.gigalixir.com",
  "id": "bb39a8f2-2dd0-4149-b54c-d33832627cfa",
  "password": "pw-fa87edae-2130-4b9b-b1ce-de9605bc1264",
  "port": 5432,
  "state": "AVAILABLE",
  "tier": "FREE",
  "url": "postgresql://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa",
  "username": "bb39a8f2-2dd0-4149-b54c-d33832627cfa-user"
}

❯ gigalixir pg
[
  {
    "app_name": "faasex",
    "database": "bb39a8f2-2dd0-4149-b54c-d33832627cfa",
    "host": "postgres-free-tier-v2020.gigalixir.com",
    "id": "bb39a8f2-2dd0-4149-b54c-d33832627cfa",
    "limited_at": null,
    "password": "pw-fa87edae-2130-4b9b-b1ce-de9605bc1264",
    "port": 5432,
    "state": "AVAILABLE",
    "tier": "FREE",
    "url": "postgresql://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa",
    "username": "bb39a8f2-2dd0-4149-b54c-d33832627cfa-user"
  }
]

❯ gigalixir config
{
  "DATABASE_URL": "ecto://bb39a8f2-2dd0-4149-b54c-d33832627cfa-user:pw-fa87edae-2130-4b9b-b1ce-de9605bc1264@postgres-free-tier-v2020.gigalixir.com:5432/bb39a8f2-2dd0-4149-b54c-d33832627cfa",
  "POOL_SIZE": "2"
}

❯ git push gigalixir
```

需要有一个 elixir_buildpack.config