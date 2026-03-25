# Script pour extraire uniquement les noms de famille depuis le fichier INSEE

# Nom du fichier original téléchargé
input_file = "dictionnaires/noms2008nat_txt/noms2008nat_txt.txt"

# Nom du fichier de sortie
output_file = "noms.txt"

# Ensemble pour éviter les doublons
noms_uniques = set()

with open(input_file, "r", encoding="utf-8") as f:
    for line in f:
        # Supprimer les espaces en début/fin et ignorer les lignes vides
        line = line.strip()
        if not line:
            continue

        # Extraire le premier "mot" avant espace (le nom)
        nom = line.split()[0]
        noms_uniques.add(nom)

# Convertir en liste et trier
noms_uniques = sorted(noms_uniques)

# Sauvegarder dans un nouveau fichier
with open(output_file, "w", encoding="utf-8") as f:
    for nom in noms_uniques:
        f.write(nom + "\n")

print(f"Fichier généré : {output_file} ({len(noms_uniques)} noms uniques)")