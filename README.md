# TerminalLang - Anotações de Frases Ilimitadas (Versão SQLite)

## Descrição
O **TerminalLang** é uma ferramenta para gerenciar anotações de frases em inglês diretamente no terminal. Com esta versão, todas as frases são armazenadas de maneira estruturada em um banco de dados **SQLite**, tornando o processo de adição, visualização, pesquisa e organização de frases mais eficiente.

Este script permite adicionar frases com suas respectivas traduções e pronúncias, visualizar as frases salvas com paginação, realizar pesquisas por palavras-chave e alterar o limite de frases exibidas por página.

## Funcionalidades

- **Adicionar Frases**: Permite adicionar frases com tradução e pronúncia.
- **Exibir Frases**: Mostra todas as frases salvas com paginação.
- **Pesquisar Frases**: Permite pesquisar por palavras-chave nas frases salvas.
- **Alterar Limite**: Modifica o número de frases exibidas por página.
- **Limpar Terminal**: Limpa a tela do terminal.

## Requisitos

- **SQLite**: Certifique-se de que o **SQLite** esteja instalado no seu sistema.
  
  Para instalar o SQLite no Linux:
  
  ```bash
  sudo apt install sqlite3
  ```

- **Bash**: O script foi desenvolvido para ser executado em sistemas que possuem Bash.

## Instalação

1. Faça o download ou clone o repositório:
   ```bash
   git clone https://github.com/Gazaxian/Terminallang-sqlite.git
   ```

2. Navegue até o diretório do projeto:
   ```bash
   cd terminal-lang
   ```

3. Torne o script executável:
   ```bash
   chmod +x terminal-lang.sh
   ```

## Como Usar

1. **Execute o Script**:
   Para iniciar o script, execute o seguinte comando no terminal:
   ```bash
   ./terminal-lang.sh
   ```

2. **Menu de Opções**:
   Após iniciar o script, você verá um menu com as seguintes opções:

   - `1) ✏️  Adicionar frases`
   - `2) 📖 Ver todas as frases`
   - `3) 🔍 Pesquisar frases`
   - `4) ⚙️ Alterar limite de frases por página`
   - `5) 🧹 Limpar terminal`
   - `6) ❌ Sair`

   Use os números para escolher a opção desejada.

## Detalhes Técnicos

- **Banco de Dados SQLite**: 
  O script utiliza um banco de dados SQLite para armazenar as frases, traduções e pronúncias. O banco de dados é criado automaticamente na primeira execução do script.

- **Estrutura do Banco de Dados**: 
  O banco de dados é composto por uma tabela chamada `frases`, com a seguinte estrutura:
  - **id** (INTEGER, chave primária)
  - **frase** (TEXT)
  - **pronuncia** (TEXT)
  - **traducao** (TEXT)

- **Pesquisa Eficiente**: 
  O SQLite oferece uma pesquisa rápida e eficiente, melhorando a performance em comparação ao uso de arquivos de texto simples.

## Como Editar o Banco de Dados

O banco de dados SQLite é armazenado em um arquivo `.sqlite` no diretório do usuário. Para editar manualmente as frases, você pode usar uma ferramenta como **DB Browser for SQLite** ou executar comandos SQL diretamente no terminal.

Exemplo de comando para visualizar o conteúdo do banco de dados:

```bash
sqlite3 ~/Documentos/Ingles/frases.db
```

No terminal do SQLite, você pode usar comandos como `SELECT * FROM frases;` para visualizar os dados.

## Licença

Este projeto é licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
