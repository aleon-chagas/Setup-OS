# Script de configuração inicial do Windows 11

## 🎯 Sobre o Projeto

Este script PowerShell automatiza a configuração inicial de uma instalação limpa do Windows 11, preparando rapidamente um ambiente completo para profissionais de SRE e DevOps.  
A automação inclui instalação/configuração de ferramentas essenciais, habilitação de recursos importantes (WSL2, Telnet), instalação de runtimes, pacotes de desenvolvimento e softwares de produtividade, além de atualizar o sistema via Chocolatey e winget.

> ⚠️ **Importante:** Execute este script com privilégios de **Administrador** logo após instalar o sistema operacional.

---

## ⚙️ Recursos e Funcionalidades

- Instalação/atualização do **Chocolatey**
- Instalação do **WSL2** com **Ubuntu 24.04**
- Ativação do **Cliente Telnet** e **Plataforma de Máquina Virtual**
- Instalação dos runtimes **.NET Desktop**, **Visual C++ Redistributable** e **.NET 6.0 Desktop**
- Ferramentas de desenvolvimento: **PowerShell 7**, **Git**, **Terraform**, **Docker Desktop**, **Vagrant**, **VirtualBox**
- Softwares de produtividade/utilitários
- Atualizações de aplicativos via **winget**
- Instalação manual do WhatsApp via Microsoft Store

---

## 🛠️ Pré-requisitos

- **Windows 11 Pro** preferencialmente
- **PowerShell** como **Administrador**
- Conexão com internet

**Para permitir execução de scripts:**
```

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
Unblock-File -Path "C:\Setup\windows_setup.ps1"

```
---

## 🚀 Como Usar

1. Baixe ou clone este projeto para uma pasta, ex.: `C:\Setup`
2. Abra o **PowerShell como Administrador**
3. Navegue até a pasta:
    ```
    cd C:\Setup
    ```
4. Execute o script:
    ```
    .\windows_setup.ps1
    ```

---

## 📦 Softwares Instalados pelo Script

| Categoria          | Ferramentas                                                                                      |
|--------------------|-------------------------------------------------------------------------------------------------|
| **Navegadores**    | Google Chrome                                                                                   |
| **Editores**       | Visual Studio Code, Sublime Text 4                                                              |
| **Comunicação**    | Slack, Microsoft Teams, Zoom                                                                    |
| **Cloud/DevOps**   | Azure Storage Explorer, Azure CLI, AWS CLI, Azure PowerShell, Remote Desktop Manager Free        |
| **Utilitários**    | PowerToys, TreeSize Free, Flameshot, oh-my-posh, WebView2 Runtime                               |
| **Produtividade**  | Notion, Google Drive                                                                            |
| **Mídia**          | OBS Studio                                                                                                      
| **Desenvolvimento**| Git, Terraform, WSL2, Docker Desktop, Vagrant, VirtualBox                       |

> 💡 Pacotes como Notion e Google Drive usam parâmetros especiais no Chocolatey (`--ignore-checksums`).

---

## ⚡️ **Configuração do Ubuntu 24.04 no WSL2**

Durante a execução do script, ao instalar o **Ubuntu 24.04** pelo WSL2, você verá mensagens como:

```

Launching Ubuntu-24.04...
Provisioning the new WSL instance Ubuntu-24.04
This might take a while...
Create a default Unix user account: ubuntu
New password:
Retype new password:

```

**Como proceder:**

1. Digite o nome do usuário desejado (ou pressione ENTER para manter "ubuntu" como padrão).
2. Digite a senha para o usuário e repita para confirmação (a senha não aparece na tela, isso é normal).
3. Após essa etapa, você cairá dentro do terminal do Ubuntu recém-instalada.

**Para voltar ao PowerShell e continuar a automação:**
- Digite `exit` e pressione ENTER **ou** simplesmente pressione `CTRL+D`.
  
Isso devolverá o controle ao PowerShell e permitirá que o script continue a instalação dos demais softwares.

> **IMPORTANTE:** Não pule esta etapa! Se não configurar o usuário e senha, o Ubuntu não funcionará corretamente.

---

## 🔍 O Que o Script Faz Passo a Passo

1. **Verifica privilégios** e versão do Windows  
2. Checa **reinicializações pendentes**  
3. Detecta **arquitetura** do sistema  
4. Instala ou atualiza **Chocolatey** (+confirmação global)  
5. Atualiza aplicativos via **winget**  
6. Ativa **Telnet Client**, **WSL2** e **Plataforma de Máquina Virtual**  
7. **Instala Ubuntu 24.04** e orienta sobre configuração de usuário/senha  
8. Instala runtimes essenciais  
9. Instala lista de aplicativos acima  
10. Instala pacotes específicos por arquitetura (ex: VirtualBox em x64)  
11. Abre a Microsoft Store para instalar **WhatsApp** (feito manualmente)  
12. Instala/atualiza **PowerShell 7**  

---

## ⚙️ Observações

- A instalação do **Vagrant** pode precisar de reinicialização
- **WSL2** e **Plataforma de Máquina Virtual** também exigem reboot para funcionar totalmente
- **WhatsApp** precisa ser instalado manualmente pela Microsoft Store após abrir
- Instalar **PowerShell 7** via winget pode levar alguns minutos

---

## 🎨 Personalização

- Para adicionar/remover softwares, edite a variável `$commonPackages` no script
- Para instalar com argumentos especiais, ajuste a variável `$specialPackages`

---

## 📜 Licença

Projeto sob **Licença MIT**. Veja o arquivo LICENSE para detalhes.

---
