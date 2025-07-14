# FIAP Food Database - Infraestrutura de Banco de Dados

## 📋 Descrição

Este repositório contém a infraestrutura como código (IaC) para provisionar o banco de dados PostgreSQL na AWS utilizando RDS, além das migrações Prisma para o **microsserviço de preparação**.

### Responsabilidades
- Provisionar instância PostgreSQL no AWS RDS
- Configurar parâmetros de performance e segurança
- Gerenciar migrações de schema com Prisma
- Configurar conectividade com o cluster EKS

## 🏗️ Arquitetura

### Tecnologias Utilizadas
- **IaC**: Terraform
- **Banco de Dados**: PostgreSQL 14
- **Cloud**: AWS RDS
- **Migrations**: Prisma ORM
- **Networking**: VPC, Subnets, Security Groups

### Especificações do Banco
- **Tipo**: PostgreSQL 14
- **Instância**: db.t3.micro (free tier)
- **Storage**: 20GB SSD
- **Backup**: 7 dias de retenção
- **Multi-AZ**: Habilitado para alta disponibilidade

## 🗄️ Schema do Banco

O banco de dados serve exclusivamente ao **microsserviço de preparação** e contém as seguintes tabelas:

```sql
-- Tabela de preparação de pedidos
CREATE TABLE preparations (
    id UUID PRIMARY KEY,
    order_id UUID NOT NULL,
    status VARCHAR(50) NOT NULL,
    estimated_time INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de histórico de status
CREATE TABLE preparation_history (
    id UUID PRIMARY KEY,
    preparation_id UUID REFERENCES preparations(id),
    status VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT NOW()
);
```

## 🚀 Deploy e Configuração

### Pré-requisitos
- AWS CLI configurado
- Terraform >= 1.5.0
- Credenciais AWS com permissões apropriadas

### Variáveis de Ambiente
```bash
# Configurar no arquivo .env ou terraform.tfvars
AWS_REGION=us-east-1
DB_USERNAME=fiap_food_user
DB_PASSWORD=<senha_segura>
DB_NAME=fiap_food_preparation
```

### Comandos de Deploy

```bash
# Inicializar Terraform
terraform init

# Planejar mudanças
terraform plan

# Aplicar infraestrutura
terraform apply

# Executar migrações Prisma
npx prisma migrate deploy
```

### Outputs Disponíveis
- `database_endpoint`: Endpoint do RDS
- `database_port`: Porta de conexão
- `database_name`: Nome do banco
- `security_group_id`: ID do security group

## 🔗 Integração com Microsserviços

### Microsserviço de Preparação
O banco PostgreSQL serve exclusivamente ao microsserviço de preparação:

```mermaid
graph TD
    A[Preparation Service] --> B[PostgreSQL RDS]
    B --> C[Preparação Table]
    B --> D[Preparation History Table]
```

### Variáveis de Conexão
```env
DATABASE_URL=postgresql://user:password@endpoint:5432/fiap_food_preparation
```

## 📊 Monitoramento

### Métricas AWS CloudWatch
- CPU Utilization
- Database Connections
- Read/Write Latency
- Free Storage Space

### Logs
- Query logs habilitados
- Slow query logs configurados
- Error logs centralizados

## 🔒 Segurança

### Configurações Implementadas
- ✅ Encrypt at rest habilitado
- ✅ Encrypt in transit (SSL/TLS)
- ✅ Security groups restritivos
- ✅ Backup automático
- ✅ Monitoring com CloudWatch

### Acesso à Rede
- Acesso apenas do cluster EKS
- Porta 5432 restrita a security groups específicos
- Sem acesso público à internet

## 🛠️ Manutenção

### Backups
- Backup automático diário
- Retenção de 7 dias
- Point-in-time recovery habilitado

### Atualizações
- Janela de manutenção: Dom 03:00-04:00 UTC
- Minor version updates automáticas
- Major version updates manuais

## 📚 Documentação Adicional

Para ver a documentação completa do projeto, acesse: [FIAP Food Docs](https://github.com/thallis-andre/fiap-food-docs)

## 👨‍💻 Autor

- **Thallis André Faria Moreira** - RM360145