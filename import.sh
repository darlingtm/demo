#!/bin/bash

CSV_FILE="/mnt/add_cd/Users.csv"


tail -n +2 "$CSV_FILE" | while IFS=';' read -r first_name last_name title phone ou street zip city country 
    
    login="${first_name}${last_name}"

    if ! samba-tool ou list | grep -q "OU=$ou,"; then
        samba-tool ou create "OU=$ou" 2>/dev/null || true
    fi

    samba-tool user create "$login" "$password" \
        --userou="OU=$ou" \
        --given-name="$first_name" \
        --surname="$last_name" \
        --job-title="$title" \
        --telephone-number="$phone" \
        --department="$street" \

    echo "Создан: $login (OU=$ou)"

done
