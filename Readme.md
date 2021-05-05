# Hiring-Challenge

O Projet foi desenvolvido utilizando Elixir-Phoenix na API e para o frontend, ReactJS. Seguindo a ideia de monorepo.

    api: Elixir-Phoenix
    front: ReactJS

## Setup

### Database

O banco de dados utilizado foi o postgres e para configurá-lo há um arquivos ```docker-compose.yml``` na raiz do projeto, responsável por inicializar um container com o mesmo na versão ```11-alpine```

Lembrando que é possível alterar as configurações default para conexão ao banco de dados no arquivo ```docker-compose.yml```

    services:
        database:
            environment: 
            POSTGRES_USER: postgres //default
            POSTGRES_PASSWORD: rpi1234 //default

```bash
$docker-compose up -d
```

### API

As configurações necessárias para setup da API em Elixir estarão dentro do diretório ```./api/config```

* dev.exs

``` elixir
config :api, Api.Repo,
  username: "postgres", #default
  password: "rpi1234", #default
  database: "hiring_challenge_dev",
  hostname: "127.0.0.1", #default
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

* dev.exs

``` elixir
config :api, Api.Repo,
  username: "postgres", #default
  password: "rpi1234", #default
  database: "hiring_challenge_test",
  hostname: "127.0.0.1", #default
  pool: Ecto.Adapters.SQL.Sandbox
```


Execute os comandos abaixo para inicializar o Phoenix:

```bash
#Compilier das dependecias
$mix deps.get
$mix deps.compile

# Setup para criação do banco de dados
$mix ecto.create
$mix ecto.migrate

# Inicialização do serviço
$mix phx.server
```

###Frontend

A única configuração necessária para o projeto frontend é a indicação do host para comunicação com a API.
O arquivo fica localizado em: ```./front/src/services/api.ts```

```js
export default Axios.create({
    baseURL: 'http://127.0.0.1:4000/api' //127.0.0.1 -> default value
})
```

Inicialização do mesmo:

```bash
$npm run start
# -- Ou se estiver usando yarn
$yarn start
```