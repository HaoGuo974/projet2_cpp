-- Création de la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS creerBD;
USE creerBD;

-- Suppression des tables dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS disponibilites;
DROP TABLE IF EXISTS enseignant;
DROP TABLE IF EXISTS groupe_cours;
DROP TABLE IF EXISTS prerequis;
DROP TABLE IF EXISTS cours;
DROP TABLE IF EXISTS programme;

-- Création de la table programme
CREATE TABLE programme (
    sigle INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    cycle ENUM('Baccalaureat', 'Maitrise', 'Doctorat', 'Certificat') NOT NULL
);

-- Création de la table cours
CREATE TABLE cours (
    code_cours VARCHAR(7) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    credit INT NOT NULL,
    capacite INT,
    sigle INT,  -- Clé étrangère vers programme
    FOREIGN KEY (sigle) REFERENCES programme(sigle) ON DELETE CASCADE
);

-- Création de la table prerequis
CREATE TABLE prerequis (
    code_cours VARCHAR(7),
    prerequis_code VARCHAR(7),
    FOREIGN KEY (code_cours) REFERENCES cours(code_cours)
);

-- Création de la table groupe_cours
CREATE TABLE groupe_cours (
    numero INT PRIMARY KEY,
    code_cours VARCHAR(7),
    FOREIGN KEY (code_cours) REFERENCES cours(code_cours)
);

-- Création de la table enseignant
CREATE TABLE enseignant (
    code_enseignant VARCHAR(12) PRIMARY KEY,
    prenom VARCHAR(100),
    nom VARCHAR(100),
    courriel VARCHAR(100),
    numero INT,  -- Clé étrangère vers groupe_cours
    FOREIGN KEY (numero) REFERENCES groupe_cours(numero)
);

-- Création de la table disponibilites
CREATE TABLE disponibilites (
    semestre ENUM('automne', 'hiver', 'ete') NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    jour ENUM('lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche') NOT NULL,
    horaire VARCHAR(100) NOT NULL,
    groupe_cours_id INT,
    code_enseignant VARCHAR(12),
    FOREIGN KEY (groupe_cours_id) REFERENCES groupe_cours(numero),
    FOREIGN KEY (code_enseignant) REFERENCES enseignant(code_enseignant)
);


-- INSERTION DES DONNEES
INSERT INTO programme(sigle, nom, cycle) VALUES
(7316, "Baccalauréat en informatique et génie logiciel", "Baccalauréat");

INSERT INTO cours(code_cours, nom, credit, capacite, sigle) VALUES
("INF1070", "Utilisation et administration des systèmes informatiques", 3, NULL, 7316),
("INF1120", "Programmation 1", 3, NULL, 7316),
("INF2050", "Outils et pratiques de développement logiciel", 3, 50, 7316),
("INF2120", "Programmation 2", 3, 60, 7316),
("INF2171", "Organisation des ordinateurs et assembleur", 3, 70, 7316),
("INF3080", "Bases de données", 3, 40, 7316),
("INF3105", "Structures de données et algorithmes", 3, 50, 7316),
("INF3135", "Construction et maintenant de logiciels", 3, 50, 7316),
("INF3173", "Principes des systèmes d'exploitation", 3, 50, 7316),
("INF3191", "Programmation web", 3, 60, 7316),
("INF3271", "Téléinformatique", 3, 70, 7316),
("INF5151", "Génie logiciel: analyse et modélisation", 3, 70, 7316),
("INF5171", "Programmation concurrente et parallèle", 3, 40, 7316),
("INF5153", "Génie logiciel: conception", 3, 70, 7316),
("INF6120", "Programmation fonctionnelle et logique", 3, 40, 7316),
("INF6150", "Génie logiciel: conduite de projets informatiques", 3, 60, 7316),
("INF1132", "Mathématiques pour l'informatique", 3, NULL, 7316),
("INF5130", "Algorithmique", 3, NULL, 7316),
("INF4681", "Statistiques pour les sciences", 3, 40, 7316),
("ECO1081", "Economie des technologie de l'information", 3, NULL, 7316),
("AOT1110", "Organisation, gestion et système d'information", 3, 25, 7316),
("INM6000", "Informatique et société", 3, 70, 7316),
("INM5151", "Projet d'analyse et de modélisation", 3, 60, 7316);


