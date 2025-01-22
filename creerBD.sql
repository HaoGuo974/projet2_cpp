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
    nom VARCHAR(100) NOT NULL
);

-- Création de la table cours
CREATE TABLE cours (
    code_cours VARCHAR(7) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    credit INT NOT NULL,
    capacite INT NOT NULL,
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
