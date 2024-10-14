-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 14 oct. 2024 à 08:26
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `snake`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `GetUserHash`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserHash` (IN `pseudo` VARCHAR(50))   BEGIN
    -- Récupère le mot de passe haché pour le pseudo donné
    SELECT mdp_hash FROM Joueurs WHERE pseudo = pseudo;
END$$

DROP PROCEDURE IF EXISTS `InsertScore`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertScore` (IN `joueur_id` INT, IN `score` INT)   BEGIN
    -- Insère un nouveau score dans la table 'Jeux'
    INSERT INTO Jeux (joueur_id, score) VALUES (joueur_id, score);
    
    -- Met à jour le meilleur score du joueur si le nouveau score est supérieur
    UPDATE Joueurs
    SET meilleur_score = score
    WHERE joueur_id = joueur_id AND meilleur_score < score;
END$$

DROP PROCEDURE IF EXISTS `InsertUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser` (IN `pseudo` VARCHAR(50), IN `mdp_hash` VARCHAR(255), IN `email` VARCHAR(100))   BEGIN
    -- Insère le nouvel utilisateur dans la table Joueurs
    INSERT INTO Joueurs (pseudo, mdp_hash, email) 
    VALUES (pseudo, mdp_hash, email);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `jeu_id` int NOT NULL AUTO_INCREMENT,
  `joueur_id` int DEFAULT NULL,
  `score` int NOT NULL,
  `dateJeu` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`jeu_id`),
  KEY `joueur_id` (`joueur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `joueurs`
--

DROP TABLE IF EXISTS `joueurs`;
CREATE TABLE IF NOT EXISTS `joueurs` (
  `joueur_id` int NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(50) NOT NULL,
  `mdp_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `meilleur_score` int DEFAULT '0',
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`joueur_id`),
  UNIQUE KEY `pseudo` (`pseudo`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `joueurs`
--

INSERT INTO `joueurs` (`joueur_id`, `pseudo`, `mdp_hash`, `email`, `meilleur_score`, `creation`) VALUES
(12, 'Snake', '$2b$10$RRtgyt7.isSKG55yjQWKlO7v3piZcmRxj7jrRpo9J8RdbqFpVn8Q.', '', 0, '2024-10-14 09:28:54');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
