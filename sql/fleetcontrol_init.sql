CREATE DATABASE IF NOT EXISTS gestion_parc;
USE gestion_parc;

CREATE TABLE CATEGORIE (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL
);

CREATE TABLE SITE (
    id_site INT AUTO_INCREMENT PRIMARY KEY,
    nom_site VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL
);

CREATE TABLE CONDUCTEUR (
    id_conducteur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    permis VARCHAR(50) NOT NULL
);

CREATE TABLE VEHICULE (
    id_vehicule INT AUTO_INCREMENT PRIMARY KEY,
    immatriculation VARCHAR(20) NOT NULL UNIQUE,
    date_achat DATE NOT NULL,
    kilometrage INT DEFAULT 0,
    statut ENUM('actif', 'maintenance', 'reforme', 'vendu') NOT NULL DEFAULT 'actif',
    id_categorie INT NOT NULL,
    id_conducteur INT,
    id_site INT NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES CATEGORIE(id_categorie)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_conducteur) REFERENCES CONDUCTEUR(id_conducteur)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_site) REFERENCES SITE(id_site)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE MISSION (
    id_mission INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(150) NOT NULL,
    description TEXT
);

CREATE TABLE TRAJET (
    id_trajet INT AUTO_INCREMENT PRIMARY KEY,
    date_depart DATETIME NOT NULL,
    date_arrivee DATETIME,
    distance DECIMAL(10,2) DEFAULT 0,
    cout DECIMAL(10,2) DEFAULT 0,
    statut ENUM('en service', 'hors service') NOT NULL DEFAULT 'en service',
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    id_mission INT,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULE(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_conducteur) REFERENCES CONDUCTEUR(id_conducteur)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_mission) REFERENCES MISSION(id_mission)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE INTERVENTION (
    id_intervention INT AUTO_INCREMENT PRIMARY KEY,
    date_intervention DATE NOT NULL,
    type_intervention VARCHAR(100) NOT NULL,
    cout DECIMAL(10,2) DEFAULT 0,
    statut ENUM('planifiee','en_cours','terminee') NOT NULL DEFAULT 'planifiee',
    id_vehicule INT NOT NULL,
    id_trajet INT,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULE(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_trajet) REFERENCES TRAJET(id_trajet)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE FOURNISSEUR (
    id_fournisseur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    contact VARCHAR(100)
);

CREATE TABLE PIECE (
    id_piece INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(150) NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    id_fournisseur INT NOT NULL,
    FOREIGN KEY (id_fournisseur) REFERENCES FOURNISSEUR(id_fournisseur)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE INTERVENTION_PIECE (
    id_intervention_piece INT AUTO_INCREMENT PRIMARY KEY,
    id_intervention INT NOT NULL,
    id_piece INT NOT NULL,
    quantite INT DEFAULT 1,
    UNIQUE (id_intervention, id_piece),
    FOREIGN KEY (id_intervention) REFERENCES INTERVENTION(id_intervention)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_piece) REFERENCES PIECE(id_piece)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE CONTRAT (
    id_contrat INT AUTO_INCREMENT PRIMARY KEY,
    type_contrat ENUM('leasing', 'assurance', 'maintenance') NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE,
    montant DECIMAL(10,2) DEFAULT 0,
    id_vehicule INT NOT NULL,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULE(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE FINANCE (
    id_finance INT AUTO_INCREMENT PRIMARY KEY,
    type_finance ENUM('trajet', 'intervention', 'contrat', 'autre') NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    date_operation DATE NOT NULL,
    id_vehicule INT NOT NULL,
    id_trajet INT,
    id_intervention INT,
    id_contrat INT,
    FOREIGN KEY (id_vehicule) REFERENCES VEHICULE(id_vehicule)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_trajet) REFERENCES TRAJET(id_trajet)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_intervention) REFERENCES INTERVENTION(id_intervention)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_contrat) REFERENCES CONTRAT(id_contrat)
        ON UPDATE CASCADE ON DELETE SET NULL
);
