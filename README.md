# 🚀 Repositório de Infraestrutura AWS via Terraform CI/CD

## 🔄 Fluxo de Trabalho (CI/CD):

Para garantir que a infraestrutura seja criada/atualizada corretamente via **GitHub Actions**, siga os passos abaixo:

1. Atualizar Secrets da Organização
  Antes de rodar o pipeline, verifique se as **secrets da organização** estão configuradas em:
  [Configurações de Secrets](https://github.com/fiap-161/tc-golunch-infra/settings/secrets/actions)

  As secrets necessárias são:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_SESSION_TOKEN`

  Essas credenciais são utilizadas pelo Terraform para autenticar na AWS.

2. Criar uma Branch a partir da `main`, dar push nas alterações
3. Abrir um Pull Request


## Infra AWS
### ☸️ Kubernetes (EKS)
- **EKS Cluster** gerenciado pela AWS, que hospeda as aplicações containerizadas.
- **Node Groups** configurados para execução dos workloads.

### 📦 Registro de Imagens (ECR)
- **Elastic Container Registry (ECR)** para armazenamento seguro das imagens Docker utilizadas nos deployments no EKS.

### 🔑 Gerenciamento de Segredos
- **AWS Secrets Manager** configurado para armazenar a URL do ECR
- Integração com workloads no **EKS**, permitindo injeção de segredos de forma segura.

### ⚙️ Pipeline CI/CD (GitHub Actions)

O repositório contém um pipeline configurado no **GitHub Actions** que executa as seguintes etapas:

1. **Validação** dos arquivos Terraform (`terraform fmt`, `terraform validate`, `terraform plan`).
2. **Provisionamento/Atualização** da infraestrutura na AWS (`terraform apply`).
3. **Criação de Backend** via script `create_backend.sh` -> backend utilizado para guardar o tf.state da infra.
4. **Deleção Secrets** via script `secret_deletion.sh` -> avitar problemas quando as secrets forem criadas novamente.
5. **Controle de versão**: qualquer mudança na infra passa pelo fluxo de *Pull Request* e é aplicada somente após revisão e aprovação.
