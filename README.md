# 🚗 FleetControl - Système de Gestion de Flotte Automobile

## 📋 Présentation du Projet

**FleetControl** est un système d'information centralisé conçu pour la gestion complète d'une flotte de véhicules destinée aux entreprises de transport, de livraison et de maintenance.

Ce projet a été développé dans le cadre d'un TP de modélisation et conception de bases de données, avec pour objectif de créer une solution robuste, évolutive et parfaitement normalisée.

---

## 🎯 Objectifs du Système

Le système FleetControl permet de :

- **Gérer un parc de véhicules** : suivi administratif, technique et financier de plusieurs centaines de véhicules
- **Tracer les déplacements** : enregistrement complet de chaque trajet (conducteur, véhicule, mission, coûts)
- **Planifier les maintenances** : historique des interventions, réparations et entretiens
- **Suivre les incidents** : liaison entre pannes, trajets interrompus et interventions techniques
- **Gérer les stocks** : suivi des pièces détachées et des fournisseurs
- **Analyser les coûts** : rapports financiers par véhicule, catégorie, période
- **Administrer les contrats** : leasing, assurances, maintenances préventives

---

## 🏗️ Architecture du Projet

```
FleetControl/
├── sql/
│   ├── fleetcontrol_init.sql      # Script d'initialisation de la base
│   └── fleetcontrol_final.sql     # Version finale avec évolutions
├── docs/
│   ├── MCD.png                     # Modèle Conceptuel de Données
│   └── MLD.png                     # Modèle Logique de Données
└── README.md                       # Documentation du projet
```

---

## 🗄️ Modèle de Données

### Entités Principales

Le système est structuré autour de **10 entités principales** :

#### 1. **VEHICULE**
Entité centrale du système contenant :
- Informations d'identification (immatriculation, catégorie)
- Données d'acquisition (date d'achat, kilométrage)
- Statut actuel (actif, maintenance, réformé, vendu)
- Relations : catégorie, conducteur attitré, site d'affectation

#### 2. **TRAJET**
Traçabilité complète des déplacements :
- Données temporelles (date départ/arrivée)
- Métriques (distance, coût)
- Statut (en service / hors service pour pannes)
- Relations : véhicule, conducteur, mission

#### 3. **INTERVENTION**
Historique des opérations de maintenance :
- Type d'intervention (entretien, réparation, contrôle)
- Suivi temporel et financier
- Liaison avec les trajets (pannes)
- Liste des pièces utilisées

#### 4. **CONDUCTEUR**
Gestion des ressources humaines :
- Informations personnelles
- Permis et qualifications
- Attribution de véhicule fixe ou partagé

#### 5. **CATEGORIE**
Classification des véhicules :
- Utilitaires
- Poids lourds
- Véhicules de service

#### 6. **SITE**
Localisation géographique :
- Sites de rattachement des véhicules
- Répartition territoriale du parc

#### 7. **MISSION**
Typologie des trajets :
- Livraison, transport, maintenance
- Description et objectifs

#### 8. **PIECE**
Gestion des stocks :
- Référencement des pièces détachées
- Prix unitaires et fournisseurs

#### 9. **FOURNISSEUR**
Réseau de partenaires :
- Fournisseurs de pièces
- Prestataires d'interventions

#### 10. **CONTRAT**
Gestion administrative :
- Contrats de leasing
- Polices d'assurance
- Contrats de maintenance
- Suivi des échéances

### Relations Clés

- Un **véhicule** peut avoir **plusieurs trajets** (1,N)
- Un **véhicule** peut avoir **plusieurs interventions** (1,N)
- Un **trajet** peut être lié à **une intervention** (panne) (0,1)
- Une **intervention** utilise **plusieurs pièces** (N,N)
- Un **véhicule** peut avoir **plusieurs contrats** (1,N)

---

## 🔧 Choix Techniques et Justifications

### Normalisation
La base de données respecte la **3ème forme normale (3FN)** :
- ✅ Élimination des redondances
- ✅ Dépendances fonctionnelles atomiques
- ✅ Pas de dépendances transitives

### Intégrité Référentielle
Stratégies de gestion des contraintes :
- **ON DELETE CASCADE** : pour les dépendances fortes (interventions → véhicules)
- **ON DELETE RESTRICT** : pour les données critiques (éviter suppression accidentelle)
- **ON DELETE SET NULL** : pour les relations optionnelles (conducteur attitré)

### Évolutivité
Le modèle a été conçu pour supporter :
- ✅ Ajout de nouvelles catégories de véhicules
- ✅ Extension des types de contrats
- ✅ Traçabilité des anomalies (Phase 2)
- ✅ Intégration de modules complémentaires

### Performance
Optimisations intégrées :
- Index automatiques sur clés primaires
- Index unique sur immatriculation
- Types de données adaptés (ENUM, DECIMAL)

---

## 📊 Évolutions du Projet

### Phase 1 : Modélisation Initiale
✅ Conception du MCD/MLD complet  
✅ Identification de toutes les entités et relations  
✅ Script SQL d'initialisation opérationnel  

### Phase 2 : Évolution Majeure (À venir)
🔄 **Traçabilité complète des anomalies**

**Besoin exprimé** : Conserver l'historique détaillé des anomalies rencontrées, leurs causes et impacts financiers.

**Impact sur le modèle** :
- Création d'une nouvelle entité **ANOMALIE**
- Liaison avec les interventions et les trajets
- Enrichissement du suivi financier
- Conservation de la compatibilité avec les données existantes

**Modifications prévues** :
```sql
-- Nouvelle table ANOMALIE avec :
- Type d'anomalie (panne mécanique, électrique, accident...)
- Cause identifiée
- Impact financier détaillé
- Gravité et criticité
- Liaison avec véhicule, trajet et intervention
```

---
