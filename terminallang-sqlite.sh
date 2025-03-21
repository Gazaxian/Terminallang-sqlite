#!/bin/bash

# Banco de dados SQLite
DB="$HOME/frases.db"

# Criar banco de dados e tabela se não existir
if [ ! -f "$DB" ]; then
    sqlite3 "$DB" "CREATE TABLE frases (id INTEGER PRIMARY KEY AUTOINCREMENT, frase TEXT);"
    sqlite3 "$DB" "CREATE INDEX idx_frase ON frases(frase);"
fi

# Configurações de desempenho sempre que o script rodar
sqlite3 "$DB" <<EOF > /dev/null 2>&1
PRAGMA synchronous = OFF;
PRAGMA journal_mode = WAL;
EOF

# Cores
BRANCO="\e[97m"
AZUL="\e[34m"
VERDE="\e[32m"
VERMELHO="\e[31m"
AMARELO="\e[33m"
LARANJA="\e[38;5;214m"  # Cor para a nova opção
RESET="\e[0m"

# Variável para o limite de frases por página
limite=5

# Adicionar frases ao banco de dados (evitando duplicatas)
adicionar_frases() {
    echo -e "${AZUL}Digite frases (inclua a pronúncia entre () e a tradução entre [])."
    echo -e "Pressione Enter sem digitar nada para sair.${RESET}"

    while true; do
        read -p "Frase: " frase
        [[ -z "$frase" ]] && break  # Sai do loop se a entrada estiver vazia

        # Escapar as aspas simples na frase
        frase_escapada=$(echo "$frase" | sed "s/'/''/g")

        # Verifica se a frase já existe no banco de dados
        if sqlite3 "$DB" "SELECT COUNT(*) FROM frases WHERE frase = '$frase_escapada';" | grep -q "1"; then
            echo -e "${VERMELHO}⚠️ Frase já cadastrada!${RESET}"
        else
            sqlite3 "$DB" "INSERT INTO frases (frase) VALUES ('$frase_escapada');"
            echo -e "${VERDE}✅ Frase salva!${RESET}"
        fi
    done
}

# Exibir frases salvas com paginação
exibir_frases() {
    # Recuperar todas as frases do banco de dados
    frases=$(sqlite3 "$DB" "SELECT frase FROM frases;")
    if [[ -z "$frases" ]]; then
        echo -e "${VERMELHO}Nenhuma frase adicionada ainda.${RESET}"
    else
        # Garantir que cada frase seja tratada como um bloco único
        mapfile -t frases_array <<< "$frases"
        total=${#frases_array[@]}
        pagina=0
        total_paginas=$(( (total + limite - 1) / limite ))

        while true; do
            clear
            inicio=$((pagina * limite))
            fim=$((inicio + limite))
            if [[ $fim -gt $total ]]; then
                fim=$total
            fi

            echo -e "📖 ${BRANCO}Frases salvas:${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${frases_array[i]}"

                # Extração da frase completa, sem dividir palavras
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done

            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima página | [P] Página anterior | [L] Alterar limite | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;  # Chama a função para alterar o limite
                q|Q) clear; break ;;
            esac
        done
    fi
}

# Pesquisar frases por palavra-chave
pesquisar_frases() {
    echo -e "${AZUL}Digite o termo de busca:${RESET}"
    read termo

    # Escapar as aspas simples no termo de busca
    termo_escapado=$(echo "$termo" | sed "s/'/''/g")

    # Pesquisar no banco de dados para buscar correspondências exatas
    resultados=$(sqlite3 "$DB" "SELECT frase FROM frases WHERE frase = '$termo_escapado';")

    if [[ -z "$resultados" ]]; then
        echo -e "${VERMELHO}Nenhuma frase encontrada.${RESET}"
    else
        # Dividir os resultados em um array
        mapfile -t resultados_array <<< "$resultados"

        total=${#resultados_array[@]}
        pagina=0
        total_paginas=$(( (total + limite - 1) / limite ))

        while true; do
            clear
            inicio=$((pagina * limite))
            fim=$((inicio + limite))
            if [[ $fim -gt $total ]]; then
                fim=$total
            fi

            echo -e "🔎 ${BRANCO}Resultados encontrados: $total${RESET}\n"
            for ((i=inicio; i<fim; i++)); do
                linha="${resultados_array[i]}"
                frase=$(echo "$linha" | sed -E 's/\(.*\)//' | sed -E 's/\[.*\]//')
                pronuncia=$(echo "$linha" | grep -oP '\(.*?\)')
                traducao=$(echo "$linha" | grep -oP '\[.*?\]')

                echo -e "${BRANCO}Frase: $frase${RESET}"
                [[ -n "$pronuncia" ]] && echo -e "${AZUL}Pronúncia: $pronuncia${RESET}"
                [[ -n "$traducao" ]] && echo -e "${VERDE}Tradução: $traducao${RESET}"
                echo -e "----------------------------------"
            done

            echo -e "${AZUL}Página $((pagina + 1))/$total_paginas${RESET}"
            echo -e "[N] Próxima página | [P] Página anterior | [L] Alterar limite | [Q] Sair"
            read -n 1 -s resposta
            case "$resposta" in
                n|N) [[ $pagina -lt $((total_paginas - 1)) ]] && ((pagina++)) ;;
                p|P) [[ $pagina -gt 0 ]] && ((pagina--)) ;;
                l|L) alterar_limite ;;  # Chama a função para alterar o limite
                q|Q) clear; break ;;
            esac
        done
    fi
}

# Limpar terminal
limpar_terminal() {
    clear
    echo -e "${VERDE}Terminal limpo!${RESET}"
}

# Alterar limite de frases por página
alterar_limite() {
    echo -e "${LARANJA}Digite o novo limite de frases por página (número positivo):${RESET}"
    read novo_limite
    if [[ "$novo_limite" =~ ^[0-9]+$ ]] && [ "$novo_limite" -gt 0 ]; then
        limite=$novo_limite
        echo -e "${VERDE}Limite de frases por página alterado para $limite!${RESET}"
    else
        echo -e "${VERMELHO}Valor inválido! Por favor, insira um número positivo.${RESET}"
    fi
}

# Menu principal
while true; do
    echo -e "\n📚 ${BRANCO}Terminallang-SQLite - Anotações de Frases Ilimitadas${RESET}\n"
    echo -e "${AZUL}1) ✏️ Adicionar frases${RESET}"
    echo -e "${VERDE}2) 📖 Ver todas as frases${RESET}"
    echo -e "${AMARELO}3) 🔍 Pesquisar frases${RESET}"
    echo -e "${VERMELHO}4) 🧹 Limpar terminal${RESET}"
    echo -e "${BRANCO}5) ❌ Sair${RESET}"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) adicionar_frases ;;
        2) exibir_frases ;;
        3) pesquisar_frases ;;
        4) limpar_terminal ;;
        5) echo -e "${VERMELHO}Saindo...${RESET}"; exit 0 ;;
        *) echo -e "${VERMELHO}Opção inválida!${RESET}" ;;
    esac

done
