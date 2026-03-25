# -*- coding: utf-8 -*-
"""
Created on Wed Mar 25 10:44:19 2026

@author: b25013618
"""

import csv

input_file = "Tenrac.csv"
output_file = "Tenrac4.sql"
table_name = "Tenrac"
batch_size = 2

def escape(value):
    value = value.strip()
    if value == "NULL":
        return "NULL"
    return "'" + value.replace("'", "''") + "'"

with open(input_file, encoding="utf-8") as f, open(output_file, "w", encoding="utf-8") as out:
    reader = csv.reader(f, delimiter=';')

    headers = next(reader)

    batch = []

    for row in reader:
        # Nettoyage des espaces
        row = [col.strip() for col in row]

        # Fusion de l'adresse si elle est en 2 colonnes
        if len(row) > len(headers):
            row[-2] = row[-2] + " " + row[-1]
            row = row[:-1]

        # Construction des valeurs
        values = "(" + ",".join(
            col if i == 0 else escape(col)  # codeMembre sans quotes
            for i, col in enumerate(row)
        ) + ")"

        batch.append(values)

        # Écriture par batch
        if len(batch) >= batch_size:
            out.write(f"INSERT INTO {table_name} ({','.join(headers)}) VALUES\n")
            out.write(",\n".join(batch))
            out.write(";\n\n")
            batch = []

    # Dernier batch
    if batch:
        out.write(f"INSERT INTO {table_name} ({','.join(headers)}) VALUES\n")
        out.write(",\n".join(batch))
        out.write(";\n")