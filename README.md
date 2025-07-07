# Bilinho 📚💸
Bilinho é uma API em Ruby on Rails para gestão de mensalidades de alunos em instituições de ensino, facilitando a criação e o controle de faturas automáticas no momento da matrícula, bem como o gerenciamento de instituições, alunos e suas matrículas.

## Funcionalidades 🚀
📘 Cadastro e gerenciamento de instituições de ensino.
👨‍🎓 Cadastro e gerenciamento de alunos.
📝 Matrícula de alunos em instituições.
💳 Geração automática de faturas mensais no momento da matrícula.
🔍 Filtros e buscas por nome, CPF, status.
🌐 API JSON pronta para integração com frontend (ou aplicações móveis).


## Tecnologias Utilizadas 🛠️
- Ruby 3.3+
- Rails 8+
- sqlite 3

## Instalação ⚙️
1️⃣ Clone o repositório:
```
git clone https://github.com/seuusuario/bilinho.git
cd bilinho
```
2️⃣ Instale as dependências:
```
bundle install
```
3️⃣ Configure o banco de dados:
```
rails db:create db:migrate db:seed
```
4️⃣ Rode o servidor:
```
rails s
```

A API estará disponível em http://localhost:3000.

## Estrutura de Entidades 🗂️

Institution

| Valor | Descrição | Entrada |
|-------|-----------|---------|
| name | Nome da Instituição | string |
| cnpj | CNPJ da Instituição | string (only Numbers) |
| institution_type | Tipo de instituição | universidade / escola / creche |
| status | Situação ativa da Instituição | enabled / disabled|

Student

| Valor | Descrição | Entrada |
|-------|-----------|---------|
| name | Nome do Aluno | string |
| cpf | CPF do Aluno | string |
| birthday | Data de nascimento do Aluno | data |
| phone | Telefone do Aluno | string |
| gender | Genero do Aluno | M / F |
| payment_method | Método de pagamento do Aluno | boleto / cartao |
| stauts | Situação ativa do Aluno | enabled / disabled |

Enrollment

-Vincula a um aluno e a uma instituição.

| Valor | Descrição | Entrada |
|-------|-----------|---------|
| full_price | Valor da matrícula | decimal |
| number_of_installments | Número de parcelas | integer |
| due_day | Dia do pagamento | integer |
| course_name | Nome do curso | string |
| institution_id | Id da Instituição | FK |
| student_id | Id do Aluno | FK |
| status | Situação ativa da matrícula | enabled / disabled |

Invoice

| Valor | Descrição | Entrada |
|-------|-----------|---------|
| invoice_price | Valor da Parcela | decimal |
| invoice_due_date | Data de Vencimento da Parcela | data |
| enrollment_id | Id da matrícula | FK |
| status | Situação ativa da parcela | open / late / paid / disabled |

## Rotas Principais 🌐
GET /institutions
POST /institutions
GET /students
POST /students
POST /enrollments
GET /invoices

(Ver detalhes de parâmetros e respostas em routes.rb ou via rails routes.)