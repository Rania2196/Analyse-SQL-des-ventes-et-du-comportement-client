CREATE DATABASE Samsung_DB;
/*
Samsung_DB
*/
-- Exercice 1 : Sélection de clients basée sur des critères multiples
SELECT
     *
FROM 
    clients_samsung
WHERE 
     Age>=30
     AND Revenu_Annuel BETWEEN 40000 AND 70000
     AND Date_Inscription >'2018-01-01'
     AND Score_Fidelite >5
ORDER BY 
        Age,Sexe;

-- Exercice 2 : Analyse des ventes avec multiples conditions
SELECT
     *
FROM 
    ventes_samsung
WHERE 
     Montant_Total>1000
     AND Score_Satisfaction <3
     AND Canal_Achat='En ligne'
     AND Delai_Livraison_Jours >20;

-- Exercice 3 :  Diversité des pays de vente
SELECT
     DISTINCT Pays_Vente
FROM 
     ventes_samsung
ORDER BY
       Pays_Vente ASC;
     
-- Exercice 4 :  Analyse des canaux de vente et satisfaction des clients
SELECT
      Canal_Achat,
	  ROUND(AVG(Score_Satisfaction),2) AS Score_satisfaction_moy,
      COUNT(*) AS Nbre_vente
FROM 
     ventes_samsung
GROUP BY 
          Canal_Achat;
          
-- Exercice 5:  Produits et leur popularité
SELECT 
     P.ID_Produit,
     P.Nom_Produit,
     P.Prix,
     SUM(V.Quantite_Vendue) AS nbre_revente
FROM
     produits_samsung P
LEFT JOIN
         ventes_samsung V
ON 
  P.ID_Produit=V.ID_Produit
GROUP BY
        P.ID_Produit,
        P.Nom_Produit,
		P.Prix;
 

-- Exercice 6: Profilage des clients
SELECT 
     Pays,
     ROUND(AVG(Age),2) AS Age_moyen,
     MAX(Revenu_Annuel) AS Revenu_annuel_max
FROM
    clients_samsung
GROUP BY
        Pays
ORDER BY 
        Pays;

-- Exercice 7: Analyse des méthodes d'expédition
SELECT
      Methode_Expedition,
      MIN(Delai_Livraison_Jours) AS delai_livraison_min,
      ROUND(AVG(Score_Satisfaction),2) AS Score_Satisfaction_moyen
FROM 
    ventes_samsung
GROUP BY
        Methode_Expedition;

-- Exercice 8: Analyse de la fidélité des clients
SELECT
      COUNT(ID_Client) AS nbre_clients,
      CASE
      WHEN Score_Fidelite<5 THEN 'FAIBLE'
      WHEN Score_Fidelite BETWEEN 5 AND 7 THEN 'MOYEN' 
      ELSE 'Elevé'
      END AS Anayse_fidelité
FROM 
    clients_samsung
GROUP BY
       Anayse_fidelité;

-- Exercice 9:  Analyse des produits populaires
SELECT 
     ID_Produit,
    SUM(Montant_Total) AS Montant_Total_ventes
FROM
     ventes_samsung
GROUP BY
       ID_Produit
HAVING 
      Montant_Total_ventes>15000;

-- Exercice 10:  Identification des pays à forte activité commerciale
SELECT
      Pays_Vente,
      Count(*) AS nbre_total_vente
FROM
    ventes_samsung
GROUP BY 
       Pays_Vente
HAVING 
      nbre_total_vente>400;
      
-- Exercice 11:  Analyse des ventes par mois
SELECT  
      DATE_FORMAT(Date_Vente,'%M') AS Mois_vente,
      SUM(Montant_Total) AS nbre_total_vente
     
FROM
    ventes_samsung
WHERE 
     YEAR(Date_Vente)='2021'
GROUP BY
        DATE_FORMAT(Date_Vente,'%M');

        
-- Exercice 12:  Classification des ventes par jour de la semaine
SELECT 
      CASE
      WHEN DATE_FORMAT(Date_Vente,'%w') IN ('0','6') THEN 'WEEKEND'
      ELSE 'Semaine'
      END AS cassification_vente_jour,
      COUNT(*) AS nbre_total_vente
FROM 
    ventes_samsung
GROUP BY 
       cassification_vente_jour;

-- Exercice 13 : Catégorisation des ventes par période de l'année
SELECT 
      CASE
      WHEN DATE_FORMAT(Date_Vente,'%m') BETWEEN 1 AND 4 THEN 'Début dannée'
      WHEN DATE_FORMAT(Date_Vente,'%m') BETWEEN 5 AND 8 THEN 'Milieu dannée'
      ELSE 'Fin dannée'
      END AS cassification_vente_mois,
      COUNT(*) AS nbre_total_vente
FROM 
    ventes_samsung
GROUP BY 
       cassification_vente_mois;

-- Exercice 14 : Clients fidèles dans des pays spécifiques
SELECT 
      ID_Client ,
      Pays,
      ROUND(AVG(Score_Fidelite),2) AS Score_Fidelite_moyen
FROM 
    clients_samsung
WHERE 
      Pays IN ('Allemagne','France')
 GROUP BY
        ID_Client,
        Pays
HAVING 
      Score_Fidelite_moyen>7;
      
-- Exercice 15 : Catégorisation des clients selon leur Revenu et Leur Âge
SELECT
     ID_Client,
     Age,
     Revenu_Annuel,
     CASE
     WHEN Age<35 AND Revenu_Annuel> 50000 THEN "Jeune à Revenu Élevé"
     WHEN Age<35 AND Revenu_Annuel BETWEEN 30000 AND 50000 THEN "Jeune à Revenu Moyen"
     WHEN Age<35 AND Revenu_Annuel < 30000 THEN "Jeune à Revenu Faible"
     WHEN Age>=35 AND Revenu_Annuel> 50000 THEN "Senior à Revenu Élevé"
     WHEN Age>=35 AND Revenu_Annuel BETWEEN 30000 AND 50000 THEN "Senior à Revenu Moyen"
     WHEN Age>=35 AND Revenu_Annuel < 30000 THEN "Senior à Revenu Faible"
     END AS Segment_Client
FROM 
     clients_samsung;

-- Exercice 16 : Tendances des ventes par mois
SELECT 
      DATE_FORMAT(Date_Vente,'%M-%Y') AS Date,
      COUNT(*) AS Volume_vente,
      SUM(Quantite_Vendue) AS quantite_totale_produit
FROM 
    ventes_samsung
GROUP BY
       DATE_FORMAT(Date_Vente,'%M-%Y');
-- Exercice 17 : Analyse croisée des produits par gamme et pays de vente
SELECT
      VS.Pays_Vente,
      PS.Gamme,
      COUNT(VS.ID_Vente) AS nbre_vente,
      SUM(VS.Montant_Total) AS Montant_Total_Vente
FROM
    ventes_samsung VS
LEFT JOIN
         produits_samsung PS
ON 
 PS.ID_Produit=VS.ID_Produit
GROUP BY
        VS.Pays_Vente,
        PS.Gamme;
-- Exercice 18 : Analyse croisée multi-dimensionnelle des performances produits
SELECT
      PS.Gamme, 
      VS.Canal_Achat,
	  COUNT(*) AS nbre_vente,
      SUM(VS.Montant_Total) AS Montant_Total_Vente,
      SUM(VS.Quantite_Vendue) AS Quantite_Total_Vente,
      ROUND(AVG(Score_Satisfaction),2) AS Satisfaction_moyenne
FROM
    ventes_samsung VS
LEFT JOIN 
       produits_samsung PS
ON 
   PS.ID_Produit=VS.ID_Produit
GROUP BY
      PS.Gamme ,
      VS.Canal_Achat
		
ORDER BY
        PS.Gamme,VS.Canal_Achat;
-- Exercice 19 : Évolution des ventes mensuelles selon les gammes de produits
SELECT
       DATE_FORMAT(Date_Vente,'%M') AS Date,
       Gamme,
       COUNT(*) AS nbre_vente,
       ROUND(AVG(Delai_Livraison_Jours),2) AS Delai_livraison_moyen
FROM
    ventes_samsung
LEFT JOIN 
         produits_samsung
ON 
     produits_samsung.ID_Produit=ventes_samsung.ID_Produit
WHERE
    YEAR(Date_Vente)='2021'
GROUP BY
         DATE_FORMAT(Date_Vente,'%M') ,
		 Gamme
ORDER BY 
        Gamme;
         
-- Exercice 20 : Analyse du comportement client
SELECT
     CS.Canal_Prefere,
     CS.Preference_Produit,
     COUNT(DISTINCT(CS.ID_Client)) AS nbre_clients,
     ROUND(AVG(CS.Score_Fidelite),2) AS fidelite_moyenne,
     SUM(VS.Montant_Total) AS montant_depensés ,
     CASE
     WHEN ROUND(AVG(CS.Score_Fidelite),2)>6 AND SUM(VS.Montant_Total)>200000 THEN 'VIP'
     ELSE 'Standard'
     END AS segmentation
FROM 
     clients_samsung CS
LEFT JOIN 
         ventes_samsung VS
ON 
  CS.ID_Client=VS.ID_Client
WHERE
      CS.Date_Inscription>'2018-01-01'
GROUP BY
       Canal_Prefere,
	   Preference_Produit;
     

    