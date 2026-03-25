import pandas as pd

# Charger le fichier (adapter le chemin)
df = pd.read_csv("dictionnaires/DptXXdepuis2000.csv", sep=";", usecols=["preusuel"])

# Supprimer les valeurs vides
df = df.dropna()

# Supprimer les doublons
df = df.drop_duplicates()

# Limiter à 250 000 lignes
df = df.head(250000)

# Sauvegarder
df.to_csv("prenom.txt", index=False, header=False)