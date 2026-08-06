# 🛒 Carrinhos de Compra API

API REST desenvolvida em **Ruby on Rails** como solução para um desafio técnico de e-commerce. A aplicação implementa o gerenciamento de carrinhos de compras, permitindo adicionar, listar, atualizar e remover produtos, além de realizar o gerenciamento automático de carrinhos abandonados utilizando processamento assíncrono com **Sidekiq**.

O projeto foi desenvolvido seguindo boas práticas do ecossistema Rails, priorizando código limpo, separação de responsabilidades, testes automatizados e uma arquitetura de fácil manutenção.

---

# 🚀 Funcionalidades

- ✅ Registrar produtos no carrinho
- ✅ Listar produtos do carrinho
- ✅ Atualizar quantidade de produtos
- ✅ Remover produtos do carrinho
- ✅ Atualização automática do valor total do carrinho
- ✅ Controle automático de carrinhos abandonados
- ✅ Exclusão automática de carrinhos expirados
- ✅ Processamento assíncrono utilizando Sidekiq
- ✅ Testes automatizados com RSpec
- ✅ Ambiente totalmente containerizado com Docker

---

# 🛠 Tecnologias

| Tecnologia | Versão |
|------------|---------|
| Ruby | 3.3.1 |
| Ruby on Rails | 7.1.3 |
| PostgreSQL | 16 |
| Redis | 7 |
| Sidekiq | Latest |
| RSpec | Latest |
| Docker | Latest |

---

# 🏗 Arquitetura

O projeto foi desenvolvido seguindo boas práticas de desenvolvimento e organização de código.

### Principais características

- Arquitetura MVC
- Controllers responsáveis apenas pelo fluxo das requisições
- Services para centralizar regras de negócio
- Jobs assíncronos utilizando Sidekiq
- Redis como backend das filas
- PostgreSQL para persistência dos dados
- Testes automatizados utilizando RSpec
- Docker para padronização do ambiente

---

# 🚀 Executando o projeto

## Clone o repositório

```bash
git clone git@github.com:RafaellMacedo/Carrinhos-de-Compra.git

cd Carrinhos-de-Compra
```

## Suba os containers

```bash
docker compose build

docker compose up
```

## Acesse o container da aplicação

```bash
docker compose exec web bash
```

## Configure o banco de dados

```bash
bundle exec rails db:create

bundle exec rails db:migrate

bundle exec rails db:seed
```

A API estará disponível em:

```
http://localhost:3000
```

---

# 🧪 Executando os testes

Criar o banco de testes:

```bash
RAILS_ENV=test bundle exec rails db:create

RAILS_ENV=test bundle exec rails db:migrate
```

Executar todos os testes:

```bash
RAILS_ENV=test bundle exec rspec
```

Executar apenas os testes da API:

```bash
bundle exec rspec spec/requests/carts_spec.rb
```

---

# ⚙ Processamento Assíncrono

O projeto utiliza **Sidekiq** juntamente com **Redis** para executar tarefas em background.

Iniciar o Sidekiq:

```bash
bundle exec sidekiq
```

Painel administrativo:

```
http://localhost:3000/sidekiq
```

---

# 🔄 Gerenciamento de Carrinhos Abandonados

Foi implementado um processo automático para gerenciamento dos carrinhos sem atividade.

### Regras implementadas

- Após **3 horas** sem interação, o carrinho é marcado como **abandonado**.
- Após permanecer abandonado por **7 dias**, o carrinho é removido automaticamente.
- O monitoramento é realizado por meio de **Jobs periódicos** executados pelo Sidekiq.

Essa estratégia permite que o processamento ocorra em background, mantendo as requisições da API rápidas e favorecendo a escalabilidade da aplicação.

---

# 📚 Endpoints

| Método | Endpoint | Descrição |
|---------|----------|-----------|
| POST | `/cart` | Adiciona um produto ao carrinho |
| GET | `/cart` | Lista os produtos do carrinho atual |
| PUT | `/cart/add_item` | Atualiza a quantidade de um produto |
| DELETE | `/cart/:product_id` | Remove um produto do carrinho |

---

# 📂 Fluxo de Desenvolvimento

O desenvolvimento foi realizado utilizando **GitHub Issues** e **Pull Requests**, permitindo organizar e documentar cada etapa da implementação.

| Funcionalidade | Issue |
|----------------|-------|
| Estrutura inicial do projeto | #1 |
| Registrar produto no carrinho | #2 |
| Listar carrinho | #5 |
| Atualizar quantidade | #7 |
| Remover produto | #8 |
| Controle de carrinhos abandonados | #9 |
| Correção dos testes existentes | #12 |

---

# 📈 Melhorias Implementadas

Além dos requisitos propostos no desafio técnico, foram implementadas melhorias para tornar a aplicação mais robusta e preparada para cenários reais.

- Tratamento de erros para requisições inválidas
- Validação de quantidade negativa
- Testes automatizados
- Docker Compose para execução da aplicação
- Seeds para popular o banco de dados
- Organização das regras de negócio em Services
- Processamento assíncrono utilizando Sidekiq

---

# 📁 Estrutura do Projeto

```text
app/
├── controllers/
├── jobs/
├── models/
├── services/
└── views/

config/
db/
spec/

Dockerfile
docker-compose.yml
```

---

# 👨‍💻 Autor

**Rafael Macedo**

Senior Full Stack Developer

**Especialidades**

- Java
- Ruby on Rails
- PHP
- React
- Vue.js
- PostgreSQL
- Redis
- Docker

GitHub: **https://github.com/RafaellMacedo**
