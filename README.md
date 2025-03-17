# Terminallang-sqlite

Terminallang-sql é uma ferramenta simples e eficaz para o aprendizado de idiomas utilizando a linha de comando. Com este script, você pode registrar, organizar e revisar frases em diferentes idiomas, além de realizar pesquisas e personalizar a visualização das frases. A nova versão agora utiliza **SQLite** para armazenar as frases, proporcionando uma estrutura mais eficiente e fácil de gerenciar.

Este projeto é ideal para quem deseja aprender idiomas de maneira prática e direta, utilizando o terminal para manter suas anotações e revisões organizadas.

## Funcionalidades

- **Adicionar Frases**: Adicione frases em qualquer idioma, com a pronúncia e tradução opcionais.
- **Revisar Frases**: Exiba as frases salvas com paginação, permitindo uma revisão eficiente.
- **Pesquisar Frases**: Encontre rapidamente frases por palavras-chave.
- **Alterar Limite de Frases por Página**: Defina o número de frases exibidas por página ao revisar ou buscar frases.
- **Limpar o Terminal**: Limpe o terminal para uma navegação mais organizada.

## Como Usar

1. **Menu de Opções**:
   Após iniciar o script, você verá um menu com as seguintes opções:

   - `1) ✏️ Adicionar frases`
   - `2) 📖 Ver todas as frases`
   - `3) 🔍 Pesquisar frases`
   - `4) ⚙️ Alterar limite de frases por página`
   - `5) 🧹 Limpar terminal`
   - `6) ❌ Sair`

   Use os números para escolher a opção desejada.
   
2. **Adicionar Frases**
   
   Para adicionar frases, digite a frase em inglês, inclua a pronúncia entre parênteses e a tradução entre colchetes. Exemplo:

   ```
   I am learning English. (ai ãm lêrning inglix) [Eu estou aprendendo inglês.]
   ```

   O script irá verificar se a frase já foi adicionada anteriormente, evitando duplicatas.

3. **Ver Todas as Frases**
   
   Você pode visualizar todas as frases salvas com paginação, facilitando a navegação e revisão.

4. **Pesquisar Frases**
   
   Digite um termo de busca para localizar frases que contenham esse termo.

5. **Alterar Limite de Frases por Página**
   
   Você pode alterar o número de frases exibidas por página, facilitando a navegação, especialmente se você tiver muitas frases salvas.

6. **Limpar o Terminal**
   
   Use esta opção para limpar o terminal, mantendo o ambiente de trabalho limpo e organizado.

## Requisitos

- **SQLite**: Certifique-se de que o **SQLite** esteja instalado no seu sistema.
  
  Para instalar o SQLite no Linux:
  
  ```bash
  sudo apt install sqlite3
  ```

- **Bash**: O script foi desenvolvido para ser executado em sistemas que possuem **Bash**.

## Como Rodar o Script

1. **Clone o Repositório**:
   ```bash
   git clone https://github.com/Gazaxian/Terminallang-sqlite/git
   ```

2. **Dê Permissão de Execução ao Script**:
   ```bash
   chmod +x terminal-lang-sqlite.sh
   ```

3. **Execute o Script**:
   ```bash
   ./terminal-lang-sqlite.sh
   ```

## Personalizações

- **Localização do Banco de Dados SQLite**: O banco de dados SQLite onde as frases são armazenadas está configurado para ser salvo em `~/Documentos/terminallang-sqlite/frases.db`. Caso deseje alterar, edite a variável `DB_PATH` no início do script.

- **Número de Frases por Página**: O número de frases exibidas por página pode ser ajustado a qualquer momento através da opção "Alterar limite de frases por página" no menu principal.

## Licença

Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
