DROP DATABASE IF EXISTS agence_voyage;
CREATE DATABASE IF NOT EXISTS agence_voyage;
USE agence_voyage;

-- Table CLIENT
CREATE TABLE IF NOT EXISTS CLIENT (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    date_naissance DATE,
    sexe VARCHAR(50),
    langue VARCHAR(50),
    devise VARCHAR(50),
    proprietaire_carte VARCHAR(100),
    numero_carte VARCHAR(50),
    expiration VARCHAR(50),
    cryptogramme VARCHAR(50)
);

-- Table HEBERGEUR
CREATE TABLE IF NOT EXISTS HEBERGEUR (
    id_hebergeur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL
);

-- Table HEBERGEMENT
CREATE TABLE IF NOT EXISTS HEBERGEMENT (
    id_hebergement INT PRIMARY KEY AUTO_INCREMENT,
    id_hebergeur INT,
    type_hebergement VARCHAR(50),
    nom VARCHAR(100) NOT NULL,
    pays VARCHAR(100) NOT NULL,
    localite VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    commentaire VARCHAR(50),
    nb_photos_max INT NOT NULL,
    nb_etoiles INT,
    appartient_chaine BOOLEAN,
    nom_chaine VARCHAR(100),
    petit_dejeuner BOOLEAN,
    horaire_arrivee TIME,
    horaire_depart TIME,
    parking BOOLEAN,
    regles VARCHAR(50),
    langues VARCHAR(50),
    nb_salles_de_bain INT,
    nombre_personnes_max INT,
    superficie INT,
    navette BOOLEAN,
    presence_restauration BOOLEAN,
    formule_restauration VARCHAR(50),
    FOREIGN KEY (id_hebergeur) REFERENCES HEBERGEUR(id_hebergeur)
);

-- Table CHAMBRE
CREATE TABLE IF NOT EXISTS CHAMBRE (
    id_chambre INT PRIMARY KEY AUTO_INCREMENT,
    id_hebergement INT,
    superficie INT NOT NULL,
    vue VARCHAR(50),
    tarif_nuit_par_personne DECIMAL(15,2) NOT NULL,
    lit_appoint BOOLEAN,
    tarif_lit_appoint DECIMAL(10,2),
    libelle VARCHAR(50),
    description VARCHAR(50),
    FOREIGN KEY (id_hebergement) REFERENCES HEBERGEMENT(id_hebergement)
);

-- Table SALLE_DE_BAIN
CREATE TABLE IF NOT EXISTS SALLE_DE_BAIN (
    id_salle_de_bain INT PRIMARY KEY AUTO_INCREMENT,
    douche BOOLEAN,
    baignoire BOOLEAN,
    serviettes BOOLEAN,
    seche_cheveux BOOLEAN
);

-- Table EQUIPEMENT
CREATE TABLE IF NOT EXISTS EQUIPEMENT (
    id_equipement INT PRIMARY KEY AUTO_INCREMENT,
    nom_equipement VARCHAR(100) NOT NULL
);

-- Table PHOTO
CREATE TABLE IF NOT EXISTS PHOTO (
    id_photo INT PRIMARY KEY AUTO_INCREMENT,
    id_hebergement INT,
    type_cible VARCHAR(50),
    url_photo VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_hebergement) REFERENCES HEBERGEMENT(id_hebergement)
);

-- Table VOL_COMPLET
CREATE TABLE IF NOT EXISTS VOL_COMPLET (
    id_vol INT PRIMARY KEY AUTO_INCREMENT,
    aeroport_depart VARCHAR(100) NOT NULL,
    heure_depart TIME NOT NULL,
    aeroport_arrivee VARCHAR(100) NOT NULL,
    heure_arrivee TIME NOT NULL,
    avion_type VARCHAR(50) NOT NULL,
    nb_sieges INT NOT NULL,
    type_sieges VARCHAR(50) NOT NULL,
    tarif VARCHAR(50) NOT NULL,
    bagage_sup_tarif VARCHAR(50) NOT NULL,
    destination VARCHAR(100) NOT NULL
);

-- Table RESERVATION
CREATE TABLE IF NOT EXISTS RESERVATION (
    id_reservation INT PRIMARY KEY AUTO_INCREMENT,
    id_client INT,
    nom_client VARCHAR(100) NOT NULL,
    prenom_client VARCHAR(100) NOT NULL,
    date_naissance DATE,
    email VARCHAR(100) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    date_reservation DATE NOT NULL,
    date_arrivee DATE,
    date_depart DATE,
    nb_adultes INT NOT NULL,
    nb_enfants INT NOT NULL,
    ages_enfants INT NOT NULL,
    id_chambre INT,
    id_vol INT,
    tarif_unitaire DECIMAL(15,2) NOT NULL,
    tarif_total DECIMAL(15,2) NOT NULL,
    numero_siege INT,
    categorie_siege VARCHAR(20),
    nb_bagages INT,
    tarif_bagages DECIMAL(15,2),
    mode_paiement VARCHAR(50) NOT NULL,
    montant_paye DECIMAL(10,2) NOT NULL,
    type_pack_voyage VARCHAR(100),
    FOREIGN KEY (id_client) REFERENCES CLIENT(id_client),
    FOREIGN KEY (id_chambre) REFERENCES CHAMBRE(id_chambre),
    FOREIGN KEY (id_vol) REFERENCES VOL_COMPLET(id_vol)
);

INSERT INTO CLIENT 
(nom, prenom, telephone, email, mot_de_passe, date_naissance, sexe, langue, devise, proprietaire_carte, numero_carte, expiration, cryptogramme)
VALUES
('Durand', 'Alice', '0601020304', 'alice.durand@mail.com', 'pass123', '1990-05-12', 'F', 'Français', 'EUR', 'Alice Durand', '1111222233334444', '12/27', '123'),
('Martin', 'Jean', '0602030405', 'jean.martin@mail.com', 'pass123', '1985-09-20', 'M', 'Français', 'EUR', 'Jean Martin', '5555666677778888', '09/26', '456'),
('Lopez', 'Maria', '0603040506', 'maria.lopez@mail.com', 'pass123', '1992-02-10', 'F', 'Español', 'EUR', 'Maria Lopez', '4444333322221111', '03/25', '789'),
('Nguyen', 'Bao', '0604050607', 'bao.nguyen@mail.com', 'pass123', '1994-07-15', 'M', 'English', 'USD', 'Bao Nguyen', '9999000011112222', '08/28', '321'),
('Smith', 'John', '0605060708', 'john.smith@mail.com', 'pass123', '1988-12-01', 'M', 'English', 'USD', 'John Smith', '3333444455556666', '05/29', '654');

INSERT INTO HEBERGEUR
(nom, prenom, adresse, telephone, email, mot_de_passe)
VALUES
('Bernard', 'Luc', '10 rue de Paris, Lyon', '0610101010', 'luc.bernard@mail.com', 'pass123'),
('Fabre', 'Elise', '5 avenue des Alpes, Nice', '0620202020', 'elise.fabre@mail.com', 'pass123');

INSERT INTO HEBERGEMENT
(id_hebergeur, type_hebergement, nom, pays, localite, adresse, commentaire, nb_photos_max, nb_etoiles, appartient_chaine, nom_chaine, petit_dejeuner, horaire_arrivee, horaire_depart, parking, regles, langues, nb_salles_de_bain, nombre_personnes_max, superficie, navette, presence_restauration, formule_restauration)
VALUES
(1, 'Hôtel', 'Hotel du Soleil', 'France', 'Nice', '12 Promenade des Anglais', 'Vue mer', 10, 4, TRUE, 'SunnyHotels', TRUE, '15:00', '11:00', TRUE, 'Non fumeur', 'Français/Anglais', 10, 50, 2000, TRUE, TRUE, 'Buffet'),
(2, 'Appartement', 'Résidence des Alpes', 'France', 'Chamonix', '55 rue des Glaciers', 'Près des pistes', 5, 3, FALSE, NULL, FALSE, '16:00', '10:00', TRUE, 'Animaux interdits', 'Français', 5, 20, 800, FALSE, FALSE, NULL),
(1, 'Villa', 'Villa Palmera', 'Espagne', 'Valencia', 'Calle del Mar 22', 'Très calme', 8, 5, FALSE, NULL, TRUE, '14:00', '12:00', TRUE, 'Silence après 23h', 'Español/Anglais', 6, 12, 500, TRUE, TRUE, 'Gourmet');

INSERT INTO CHAMBRE
(id_hebergement, superficie, vue, tarif_nuit_par_personne, lit_appoint, tarif_lit_appoint, libelle, description)
VALUES
(1, 25, 'Mer', 120.00, TRUE, 30.00, 'Chambre Standard', 'Confortable'),
(1, 40, 'Mer', 190.00, FALSE, NULL, 'Suite Deluxe', 'Spacieuse'),
(2, 30, 'Montagne', 80.00, TRUE, 20.00, 'Studio', 'Près des pistes'),
(3, 50, 'Jardin', 150.00, TRUE, 25.00, 'Master Suite', 'Très calme');

INSERT INTO SALLE_DE_BAIN
(douche, baignoire, serviettes, seche_cheveux)
VALUES
(TRUE, FALSE, TRUE, TRUE),
(FALSE, TRUE, TRUE, TRUE),
(TRUE, TRUE, TRUE, FALSE);

INSERT INTO EQUIPEMENT (nom_equipement)
VALUES
('Wi-Fi'),
('Climatisation'),
('Télévision'),
('Mini-bar'),
('Coffre-fort');

INSERT INTO PHOTO (id_hebergement, type_cible, url_photo)
VALUES
(1, 'extérieur', 'photo1.jpg'),
(1, 'chambre', 'photo2.jpg'),
(2, 'extérieur', 'photo3.jpg'),
(3, 'piscine', 'photo4.jpg');

INSERT INTO VOL_COMPLET
(aeroport_depart, heure_depart, aeroport_arrivee, heure_arrivee, avion_type, nb_sieges, type_sieges, tarif, bagage_sup_tarif, destination)
VALUES
('CDG', '10:00', 'JFK', '12:30', 'A350', 300, 'Eco/Business', '500', '70', 'New York'),
('Nice', '14:00', 'Barcelone', '15:15', 'A320', 180, 'Eco', '120', '40', 'Barcelone'),
('Madrid', '09:00', 'Valencia', '10:00', 'ATR72', 70, 'Eco', '90', '20', 'Valencia');

INSERT INTO RESERVATION
(id_client, nom_client, prenom_client, date_naissance, email, telephone, date_reservation, date_arrivee, date_depart, nb_adultes, nb_enfants, ages_enfants, id_chambre, id_vol, tarif_unitaire, tarif_total, numero_siege, categorie_siege, nb_bagages, tarif_bagages, mode_paiement, montant_paye, type_pack_voyage)
VALUES
(1, 'Durand', 'Alice', '1990-05-12', 'alice.durand@mail.com', '0601020304',
 '2024-05-01', '2024-07-10', '2024-07-15', 
 2, 1, 7, 
 1, 1, 120.00, 360.00, 12, 'Eco', 1, 70.00, 'Visa', 430.00, 'Séjour + Vol'),

(2, 'Martin', 'Jean', '1985-09-20', 'jean.martin@mail.com', '0602030405',
 '2024-04-10', '2024-08-05', '2024-08-12', 
 2, 0, 0, 
 2, 2, 190.00, 1330.00, 8, 'Eco', 0, 0, ' Mastercard', 1330.00, 'Hôtel'),

(3, 'Lopez', 'Maria', '1992-02-10', 'maria.lopez@mail.com', '0603040506',
 '2024-06-01', '2024-09-01', '2024-09-10',
 1, 2, 4,
 3, 3, 80.00, 680.00, 4, 'Eco', 2, 40.00, 'Visa', 720.00, 'Séjour');

-- Requêtes simples
SELECT id_client, nom, prenom, email
FROM CLIENT;

SELECT nom, pays, localite
FROM HEBERGEMENT
WHERE pays = 'France';

SELECT id_chambre, libelle, tarif_nuit_par_personne
FROM CHAMBRE;

-- Requêtes normales

-- 1 Cette requête permet d’afficher les chambres de l’hôtel « Hotel du Soleil » avec leur surface et leur prix par nuit.

SELECT c.id_chambre, c.libelle, c.superficie, c.tarif_nuit_par_personne
FROM CHAMBRE c
JOIN HEBERGEMENT h ON c.id_hebergement = h.id_hebergement
WHERE h.nom = 'Hotel du Soleil';

-- 2 Cette requête permet de compter le nombre d’hébergements par pays et de les classer du pays le plus représenté au moins représenté.

SELECT pays, COUNT(*) AS nb_hebergements
FROM HEBERGEMENT
GROUP BY pays
ORDER BY nb_hebergements DESC;

-- 3 Cette requête permet de retrouver les réservations d’un client à partir de son adresse email.

SELECT r.id_reservation, r.date_reservation, r.tarif_total
FROM RESERVATION r
JOIN CLIENT c ON r.id_client = c.id_client
WHERE c.email = 'exemple@gmail.com';

-- Requêtes complexes

-- 1 Cette requête permet d’afficher chaque hébergement avec le nombre de chambres qu’il possède et le prix moyen par nuit, classés du moins cher au plus cher.

SELECT 
    h.id_hebergement,
    h.nom AS hebergement,
    COUNT(c.id_chambre) AS nb_chambres,
    AVG(c.tarif_nuit_par_personne) AS tarif_moyen
FROM HEBERGEMENT h
LEFT JOIN CHAMBRE c ON c.id_hebergement = h.id_hebergement
GROUP BY h.id_hebergement, h.nom
ORDER BY tarif_moyen ASC;

-- 2 Cette requête permet d’afficher le détail des réservations avec le client, la chambre, le vol et le montant total, en commençant par les plus récentes.

SELECT 
    r.id_reservation,
    c.nom AS nom_client,
    c.prenom AS prenom_client,
    ch.libelle AS chambre,
    v.aeroport_depart,
    v.aeroport_arrivee,
    r.tarif_total
FROM RESERVATION r
JOIN CLIENT c ON r.id_client = c.id_client
LEFT JOIN CHAMBRE ch ON r.id_chambre = ch.id_chambre
LEFT JOIN VOL_COMPLET v ON r.id_vol = v.id_vol
ORDER BY r.date_reservation DESC;

-- 3 Cette requête permet de trouver les chambres disponibles sur une période donnée, en excluant celles qui sont déjà réservées sur ces dates.

SELECT ch.id_chambre, ch.libelle, ch.tarif_nuit_par_personne
FROM CHAMBRE ch
WHERE ch.id_chambre NOT IN (
    SELECT r.id_chambre
    FROM RESERVATION r
    WHERE r.date_arrivee < '2025-07-20'
      AND r.date_depart > '2025-07-10'
);
