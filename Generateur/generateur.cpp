#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <cstdlib>
#include <ctime>

// Renvoie un tableau contenant chaque ligne d'un fichier
std::vector<std::string> dictionaryOpener(const std::string dictionaryName){
	std::ifstream dictionary;
	dictionary.open(dictionaryName);

	std::vector<std::string> words;
	std::string line;

	while(std::getline(dictionary, line)){
		words.push_back(line);
	}

	dictionary.close();
	return words;
}

// Genere un entier positif
unsigned positiveIntegerGenerator(const unsigned min, const unsigned max){
	return ((rand() % (max - min + 1)) + min);
}

// Genere une chaine de caractere en fonction d'un dictionnaire
std::string stringGenerator(const std::vector<std::string> dictionary){
	return dictionary[rand() % dictionary.size()];
}

// Genere une date entre le 01.01.2000 et le 31.12.2026
std::string dateGenerator(){
	std::string date = "";

	unsigned year = rand() % (2026 - 2000) + 2001;
	unsigned month = rand() % 12 + 1;
	unsigned day;

	switch(month) {
	case 1:
		day = rand() % 31 + 1;
		break;
	case 2:
		day = rand() % 28 + 1;
		break;
	case 3:
		day = rand() % 31 + 1;
		break;
	case 4:
		day = rand() % 30 + 1;
		break;
	case 5:
		day = rand() % 31 + 1;
		break;
	case 6:
		day = rand() % 30 + 1;
		break;
	case 7:
		day = rand() % 31 + 1;
		break;
	case 8:
		day = rand() % 31 + 1;
		break;
	case 9:
		day = rand() % 30 + 1;
		break;
	case 10:
		day = rand() % 31 + 1;
		break;
	case 11:
		day = rand() % 30 + 1;
		break;
	case 12:
		day = rand() % 31 + 1;
		break;
	default:
		day = rand() % 28 + 1;
		break;
	}

	date = std::to_string(month) + "-" + std::to_string(day) + "-" + std::to_string(year);

	return date;
}

// Genere un numero de telephone commencant par 06 ou 07
std::string phoneNumberGenerator(){
	unsigned tempNumber;
	std::string number = "";

	number += (rand() % 2 == 0 ? "06" : "07");
	for(unsigned i (0); i < 5; ++i){
		tempNumber = (rand() % 100);
		number += (tempNumber < 10 ? "-0" + std::to_string(tempNumber) : "-" + std::to_string(tempNumber));
	}

	return number;
}

// Genere un eMail en fonction du prenom et du nom du proprietaire
std::string mailGenerator(const std::string firstname, const std::string lastname, const std::vector<std::string> dictionary){
	return (firstname + "." + lastname + "@" + dictionary[rand() % dictionary.size()]);
}

/*
	Genere une adresse contenant :
		- le numero
		- 1/4 que le numero soit accompagne de "bis"
		- le lieu-dit en fonction d'un dictionnaire
		- la ville (contenant le code postal et le nom) en fonction d'un dictionnaire
*/
std::string addressGenerator(const std::vector<std::string> locality, const std::vector<std::string> city){
	std::string bis = (rand() % 4 == 0 ? "bis" : "");
	unsigned number = rand() % 1000;
	return (std::to_string(number) + bis + " " + locality[rand() % locality.size()] + ", " + city[rand() % city.size()]);
}

int main(const int argc, const char *argv[]){
	srand(time(nullptr));
	if (argc < 2) return 1;

	std::ofstream file("Organisme.csv");
	const unsigned numberOfElements = 10;

	std::string header = "";
	for(unsigned i (1); i < argc-1; ++i){
		header += argv[i];
		header += ";";
	}
	header += argv[argc-1];
	header += "\n";

	file << header;

	std::vector<std::string> firstname = dictionaryOpener("../dictionnaires/prenoms.txt");
	std::vector<std::string> lastname = dictionaryOpener("../dictionnaires/noms.txt");
	std::vector<std::string> locality = dictionaryOpener("../dictionnaires/lieux-dits.txt");
	std::vector<std::string> city = dictionaryOpener("../dictionnaires/villes.txt");
	std::vector<std::string> domainName = dictionaryOpener("../dictionnaires/noms-de-domaine.txt");
	std::vector<std::string> grade = dictionaryOpener("../dictionnaires/grades.txt");
	std::vector<std::string> rang = dictionaryOpener("../dictionnaires/rangs.txt");
	std::vector<std::string> titre = dictionaryOpener("../dictionnaires/titres.txt");
	std::vector<std::string> dignite = dictionaryOpener("../dictionnaires/dignites.txt");

	unsigned dataAttribute1;
	std::string dataAttribute2;
	std::string dataAttribute3;
	std::string dataAttribute4;
	std::string dataAttribute5;
	std::string dataAttribute6;
	std::string dataAttribute7;
	std::string dataAttribute8;
	std::string dataAttribute9;
	std::string dataAttribute10;
	std::string dataAttribute11;
	std::string dataAttribute12;
	

	for(unsigned i (0); i < numberOfElements; ++i){
		dataAttribute1 = i;
		dataAttribute2 = std::to_string(rand() % numberOfElements);
		dataAttribute3 = std::to_string(rand() % numberOfElements);
		dataAttribute4 = stringGenerator(lastname);
		dataAttribute5 = stringGenerator(firstname);
		dataAttribute6 = mailGenerator(dataAttribute4, dataAttribute5, domainName);
		dataAttribute7 = phoneNumberGenerator();
		dataAttribute8 = addressGenerator(locality, city);
		dataAttribute9 = stringGenerator(grade);
		dataAttribute10 = stringGenerator(dignite);
		dataAttribute11 = stringGenerator(titre);
		dataAttribute12 = stringGenerator(rang);

		file << dataAttribute1;
		file << ";";
		file << dataAttribute2;
		file << ";";
		file << dataAttribute3;
		file << ";";
		file << dataAttribute4;
		file << ";";
		file << dataAttribute5;
		file << ";";
		file << dataAttribute6;
		file << ";";
		file << dataAttribute7;
		file << ";";
		file << dataAttribute8;
		file << ";";
		file << dataAttribute9;
		file << ";";
		file << dataAttribute10;
		file << ";";
		file << dataAttribute11;
		file << ";";
		file << dataAttribute12;
		file << "\n";
	}

	file.close();
	return 0;
}