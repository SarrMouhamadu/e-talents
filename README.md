# E-Talent 🏀🇸🇳

**E-Talent** est une application mobile native Apple (iOS) dédiée à la mise en lumière, au partage et à la détection des talents du basketball sénégalais.

> *« Crée ton profil. Montre ton talent. Fais-toi découvrir. »*

---

## 📱 Aperçu de l'Application

E-Talent permet aux joueurs de :
* Créer une fiche sportive complète (taille, poste, âge, ville, club, disponibilité).
* Partager des highlights vidéo (16:9) et des photos de match/entraînements (4:5).
* Être visibles auprès des coachs et des recruteurs au Sénégal et à l'international.
* Échanger directement via une messagerie privée.

E-Talent permet aux clubs de :
* Présenter leur identité, leur palmarès et leur division.
* Publier des actualités et annonces de détections.
* Présenter leur effectif de joueurs.

---

## 🛠️ Stack Technique

* **Langage** : Swift 5.9+ / Swift 6 ready (Concurrence moderne avec `MainActor` et `async/await`)
* **Interface Utilisateur** : SwiftUI déclaratif natif
* **Gestion d'état** : Macro `@Observable` (Framework Observation)
* **Architecture** : MVVM léger, orienté composants réutilisables
* **Design System** :
  * Orange Signature : `#FF6A00`
  * Noir Profond : `#0B0B0D`
  * Dark Surface : `#151518`
  * Blanc Pur : `#FFFFFF`
  * Gris Secondaire : `#737373`
  * Micro-accents identitaires Sénégal (Vert, Jaune, Rouge)

---

## 📂 Architecture du Projet

```text
e-talent/
├── App/
│   └── ETalentApp.swift               # Point d'entrée principal (@main)
├── Core/
│   ├── DesignSystem/                  # Couleurs, Typographie, Espacements, Rayons
│   ├── Components/                    # Composants réutilisables (Boutons, Cartes, etc.)
│   └── Extensions/                    # Helpers Color & View
├── Models/                            # Modèles Player, Club, Post, Message, Mocks
├── Features/
│   ├── Onboarding/                    # Splash, Welcome, Choix du compte, Création profil
│   ├── Main/                          # Tab Bar native 5 onglets
│   ├── Home/                          # Feed social & carrousel des talents
│   ├── Discover/                      # Moteur de recherche et filtres postes/villes
│   ├── CreatePost/                    # Publication de médias photos et vidéos
│   ├── Messages/                      # Liste des conversations et messagerie directe
│   ├── Notifications/                 # Alertes, likes, visites de profil
│   └── Profile/                       # Profil joueur, profil club et espace personnel
└── Services/                          # MockDataService (@Observable)
```

---

## 🚀 Lancer le Projet

1. Ouvrez le projet dans **Xcode** :
   ```bash
   open e-talent.xcodeproj
   ```
2. Sélectionnez une cible de simulation (ex. *iPhone 16 Pro* ou *iPhone SE*).
3. Appuyez sur `Cmd + R` pour lancer l'application.

---

## 📄 Licence & Droits

Projet développé pour **E-Talent Basketball Sénégal**. Tous droits réservés.
