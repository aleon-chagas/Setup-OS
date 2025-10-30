# 🚀 Script de configuração para Ubuntu 24.04 LTS

## 🎯 Sobre o Projeto

Este playbook Ansible automatiza toda a configuração inicial de uma instalação limpa do **Ubuntu 24.04 LTS**, preparando rapidamente um ambiente completo para profissionais de SRE e DevOps.
A automação cobre desde a instalação do Ansible em ambiente virtual até utilitários básicos, ferramentas cloud/devops e aplicativos de produtividade.

> ⚠️ **Importante:** Execute este playbook em uma instalação limpa e com privilégios de **sudo** para garantir máxima compatibilidade!

***

## ⚙️ Recursos e Funcionalidades

- Instalação do **Ansible** em ambiente virtual isolado
- Limpeza automática de repositórios/chaves obsoletos
- Instalação e atualização de **pacotes base**, utilitários de linha de comando e sistemas de shell personalizados (Oh-My-Zsh)
- Instalação automática de:
    - **Docker** e dependências
    - CLI e auxiliares Kubernetes
    - Ferramentas DevOps (Terraform, AWS CLI, Azure CLI, yq, Vagrant, etc.)
    - Pacotes gráficos e utilitários de produtividade: Chrome, Slack, Zoom, VS Code, Sublime Text, Thunderbird, Bitwarden, Notion, entre outros
    - Configuração e otimização do terminal (**Tilix** + **Zsh**)
    - Limpeza de pacotes desnecessários após o provisionamento

***

## 🛠️ Pré-requisitos

- **Ubuntu Desktop 24.04 LTS**
- Acesso sudo à máquina
- Conexão com internet

***

## 🐍 Instalação do Ansible (Virtualenv recomendada)

Para isolar o Ansible e garantir compatibilidade, recomenda-se instalá-lo em um ambiente virtual Python conforme o passo a passo abaixo:

```bash
# Atualize o sistema e instale dependências
sudo apt update && sudo apt install python3-venv sshpass -y


# Crie o ambiente virtual
python3 -m venv pyenv


# Para entrar no ambiente virtual
source pyenv/bin/activate


# Atualize pip e instale Ansible
pip install --upgrade pip && pip install ansible


# Verifique a instalação
ansible --version
```

Para sair:

```bash
deactivate
```

***

## 🚀 Como Usar

1. Baixe ou clone este repositório:

```bash
git clone <URL-DO-REPOSITORIO>
cd <PASTA-CLONADA>
```

2. Ative seu ambiente virtual Python com Ansible instalado:

```bash
source pyenv/bin/activate
```

3. Execute o playbook:

```bash
ansible-playbook ubuntu_setup.yml -K
```

> O parâmetro `-K` solicita sua senha de sudo, necessária para operações privilegiadas.

***

## 📦 Softwares e Ferramentas Instaladas

| Categoria | Ferramentas |
| :-- | :-- |
| **Terminal/Shell** | Tilix, Zsh, Oh-My-Zsh, Powerlevel10k, plugins: syntax-highlighting, autosuggestions, Fzf, Fonts MesloLGS |
| **Cloud/DevOps** | Docker, Kubernetes CLI/k9s/kubectx/kubens/minikube, AWS CLI, Azure CLI, Terraform, Vagrant, yq |
| **Sistema Base** | Htop, Iftop, Iotop, Glances, Ncdu, Tree, Neofetch, Speedtest-cli, Net-tools, Plocate, Btop, Nmap |
| **Desenvolvimento** | Git, Vim, Tmux, Sublime Text 4, VS Code, MySQL Client, Ansible-lint, Node Js |
| **Browsers** | Google Chrome, Vivaldi|
| **Produtividade** | Thunderbird, Zoom, Slack, Teams, Notion, Bitwarden, Azure Storage Explorer, Flameshot, OBS Studio |


> 💡 Ferramentas como Zoom, Remote Desktop Manager, Vagrant e K9s são baixadas e instaladas na versão mais recente disponível.

***

## ⚙️ Personalização e Plugins Zsh

- O Oh-My-Zsh é instalado automaticamente no diretório do usuário.
- O tema Powerlevel10k é configurado como padrão.
- Plugins essenciais para produtividade no shell são clonados e configurados:
    - `zsh-syntax-highlighting`
    - `zsh-autosuggestions`
    - `zsh-completions`

***

## ⚡️ O Que o Playbook Faz Passo a Passo

1. 📦 Instala os pacotes e utilitários essenciais do sistema
2. 🐳 Adiciona keyring e instala Docker com dependências e permissões de grupo
3. ☸️ Prepara ambiente Kubernetes, instala CLI, complementos e ferramentas auxiliares
4. ☁️ Instala e configura AWS CLI, Azure CLI, Terraform, Vagrant, yq e outros DevOps essentials
5. 🐚 Configura Tilix como terminal e ativa Zsh + Oh-My-Zsh para uma experiência aprimorada
6. 🖥 Instala navegadores, editores, ferramentas de produtividade e utilitários gráficos populares
7. 🧹 Limpa pacotes desnecessários e atualiza índices do locate ao final

***

## 🎨 Personalização

- Edite as variáveis `base_packages`, `util_packages` e `devops_apps` do arquivo `ubuntu_setup.yml` conforme suas necessidades
- Adicione ou remova blocos conforme seu workflow

***

## 🛠️ Dicas de Pós-Instalação \& Customizações

### 🧰 Elevando sua Experiência no Terminal

Desbloqueie produtividade avançada e agilize seu fluxo de trabalho com esta coleção de plugins, aliases e funções desenvolvidas para o terminal Linux. Seja para DevOps, administração de sistemas, desenvolvimento ou uso pessoal, esses atalhos foram criados para facilitar tarefas cotidianas como navegação de arquivos, comandos Docker e Kubernetes, operações com Git, monitoramento do sistema, gestão de pacotes e plugins oferecendo recursos como realce de sintaxe, sugestões automáticas, autocompletar avançado e muito mais.

Utilize esses comandos para simplificar rotinas complexas, reduzir digitação repetitiva e manter um ambiente organizado e eficiente.

> Copie os plugins e aliases para seu arquivo `.zshrc` ou similar para que estejam disponíveis em todas as sessões de terminal.

🌱 Plugins

No Zsh, os plugins são módulos adicionais que expandem as funcionalidades do shell, oferecendo recursos como realce de sintaxe, sugestões automáticas, autocompletar avançado e muito mais.

```
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  zsh-completions
  command-not-found
)
```

🏢 Intelie Azure Shortcuts

```bash
# Intelie Azure Subscriptions Aliases
alias aznonprod='az account set -s 8aeabc8b-7e44-4f8c-a91f-b61ca0cade81'
alias azprod='az account set -s 85b654bd-ae67-492c-82bb-56c28c7cd55a'
alias azpremium='az account set -s 3519381e-56d3-4bca-8c95-5ba587bf4699'
alias azgithub='az account set -s 558c53c4-bce9-4c77-9fbe-1794afceb0d6'
```
🔐 Generate New Certificates for Intelie VPN

```bash
# Intelie VPN Aliases
alias gen-cert="az ssh config --ip * --file /tmp/temp.conf"
```

☁️ Azure CLI

```bash
# Azure Login Aliases
function az() {
  # Checks if the first argument is 'login'
  if [[ "$1" == "login" ]]; then
    # If 'login', uses device code for login and passes remaining arguments
    command az login --use-device-code "${@:2}"
  else
    # Otherwise, executes the original AZ CLI command
    command az "$@"
  fi
}
```

📁 Navigation & Filesystem

```bash
# Navigation Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -CF'
alias ls='ls -lh --color=auto'              # Improved ls view
alias la='ls -lah --color=auto'
alias cp='cp -iv'                           # Confirm before overwriting
alias mv='mv -iv'                           # Confirm before overwriting
alias cls='clear'
alias mkdir='mkdir -pv'                     # Create parent directories if necessary
```

🐳 Docker

```bash
# Docker Aliases
alias up='docker compose up -d'
alias down='docker compose down'
alias dps='docker ps'
alias di='docker images'
alias dpa='docker ps -a'
alias drm='docker rm'
alias drmi='docker rmi'
alias dlogs='docker logs -f'
alias dexec='docker exec -it'
alias dbash='docker exec -it $1 /bin/bash'
alias dsh='docker exec -it $1 /bin/sh'
alias dbuild='docker build -t'
```

☸️ Kubernetes

```bash
# K8s Aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kga='kubectl get all'
alias kctx='kubectl config use-context'
alias kdel='kubectl delete'
```

⚡ Git

```bash
# Git Aliases
alias g='git'
alias gst='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gcm='git checkout main'
alias gcd='git checkout dev'
alias gcb='git checkout -b'
# Git Shortcuts
function d () {
    git add .
    git commit -m "Automated commit"
    git push
}
```

🖥️ System & Networking

```bash
# System Aliases
alias df='df -h'                            # Show disk usage
alias du='du -sh * | sort -h'               # Show folder sizes sorted
alias myip='curl ifconfig.me'               # Show public IP
alias ports='netstat -tulanp'               # Show all open ports and processes
alias ping='ping -c 5'                      # Ping with 5 packets
alias h='history'
alias j='jobs -l'                           # List background jobs
alias c='clear'                             # Clear terminal
```

📦 Package Manager

```bash
# Package Aliases
alias apt-update='sudo apt update -y'
alias apt-upgrade='sudo apt upgrade -y'
alias apt-remove='sudo apt autoremove -y'
alias apt-search='sudo apt search'
alias apt-install='sudo apt install -y'
alias snap-install='sudo snap install'
alias snap-remove='sudo snap remove'
alias snap-refresh='sudo snap refresh'
```

### 📝 Otimizando o VIM global para YAML

Abra e edite o VIM global para facilitar edição de YAML e melhorar visualização:

```bash
sudo vim /etc/vim/vimrc +$
```

Inclua ao final:

```
" YAML Resources

set cursorline
set cursorcolumn
set number
set paste

" Indentação ideal para YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
```

Essas opções oferecem destaque da linha/coluna, numeração, fácil colagem de código, e identação correta para arquivos YAML, seguindo as melhores práticas para edição de playbooks Ansible e infraestrutura como código.

***

### 🖥️ Definindo Tilix como terminal padrão (`CTRL+ALT+T`)

Para que o atalho clássico `CTRL+ALT+T` abra o Tilix, rode:

```bash
sudo update-alternatives --config x-terminal-emulator
```

Selecione o número correspondente ao **Tilix** (geralmente `/usr/bin/tilix.wrapper`) e pressione ENTER.
Se necessário, crie a entrada (só precisa fazer uma vez):

```bash
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/tilix 1
```

Agora o Tilix assumirá o atalho e demais comandos de abertura de terminal!.

***

### 🔥 Atalho rápido para Flameshot

Para capturas de tela rápidas configure um atalho customizado:

1. Acesse **Configurações > Atalhos de Teclado > Novo Atalho Personalizado**
2. Nome: `flameshot`
3. Comando:
    - Para ambientes X11:

```
flameshot gui
```
Para ambientes Wayland (ex: GNOME 44+):
```
sh -c "QT_QPA_PLATFORM=wayland flameshot gui"
```

4. Defina o atalho desejado, como `SHIFT+SUPER+S`
Pronto! Use o atalho para abrir a interface de recorte do Flameshot instantaneamente.

***

## 📜 Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo LICENSE para mais detalhes.

***

> Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests 😄