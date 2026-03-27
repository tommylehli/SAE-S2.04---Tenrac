import csv

input_file = "Forme.csv"
output_file = "Forme.sql"
table_name = "Forme" 

# Liste les noms exacts de tes colonnes de type DATE ici
DATE_COLUMNS = ["dateDeb", "dateFin", "date_"] 

def format_value(value, is_date=False):
    value = value.strip()
    
    # 1. Gestion du NULL (prioritaire)
    if value.upper() == "NULL" or value == "":
        return "NULL"
    
    # 2. Nettoyage des quotes internes pour éviter les injections/erreurs
    clean_val = value.replace("'", "''")
    
    # 3. Si c'est une colonne identifiée comme DATE
    if is_date:
        return f"DATE '{clean_val}'"
    
    # 4. Si c'est un nombre pas de guillemets
    if value.isdigit():
        return value
    
    # 5. Sinon, texte standard
    return f"'{clean_val}'"

with open(input_file, encoding="utf-8") as f, open(output_file, "w", encoding="utf-8") as out:
    reader = csv.reader(f, delimiter=';')
    
    try:
        headers = [h.strip() for h in next(reader)]
        
        is_date_map = [h in DATE_COLUMNS for h in headers]
        
        out.write(f"INSERT INTO {table_name} ({','.join(headers)}) VALUES\n")

        rows_to_write = []
        for row in reader:
            row = [col.strip() for col in row]

            if len(row) > len(headers):
                row[len(headers)-1] = row[len(headers)-1] + " " + row[len(headers)]
                row = row[:len(headers)]

            # Formatage de chaque cellule selon son type
            formatted_cells = []
            for i, val in enumerate(row):
                formatted_cells.append(format_value(val, is_date=is_date_map[i]))
            
            rows_to_write.append(f"({','.join(formatted_cells)})")

        # Ecriture finale 
        out.write(",\n".join(rows_to_write) + ";")
        
        print(f"Succès ! Le fichier {output_file} contient maintenant le format DATE '...'.")

    except StopIteration:
        print("Erreur : Le fichier CSV est vide.")