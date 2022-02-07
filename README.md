# Test technique iOS Netgem

Exercice de recrutement officiel de Netgem, réalisé par Koussaïla BEN MAMAR, le 07/02/2022.

## Table des matières
- [Objectifs](#objectif)
- [Ma solution](#solution)

## <a name="objectif"></a>Objectifs

Afficher des GIFs de GIPHY (Faites simple).

Nous voulons vérifier:
- Si vous savez implémenter l'API
- Si vous savez afficher des GIFs
- La qualité du code

Le test se compose en 3 user stories:

1) En tant qu'utilisateur, dès que je lance l'application, je devrai vois donc un GIF aléatoire.

2) En tant qu'utilisateur, lorsque je clique sur le bouton de recherche, je devrai voir donc tous les GIFs correspondants à ma recherche.

3) En tant qu'utilisateur, lorsque je tape sur un GIF dans la liste (user story n°2), je devrais voir le GIF en plein écran.


### Instructions
- N'hésitez pas à implémenter votre propre architecture
- N'hésitez pas à implémenter votre propre design
- Vous pouvez utiliser des librairies tierces (externes)
- Vous devriez faire des tests unitaire de votre application
- Partagez votre projet de la façon de votre choix (GitHub, zip, ...)

### Documentation

GIPHY API: https://developers.giphy.com/docs/

## <a name="solution"></a>Ma solution

Pour ce test technique, je propose une solution simple en 3 `ViewControllers`. Pour les user stories 1 et 2, j'utilise un `TabBarController`. L'architecture que je propose est en **MVVM**.

### Frameworks utilisés
- UIKit
- Combine (Programmation réactive fonctionnelle, data binding MVVM)
- Alamofire (HTTP)
- Kingfisher (Gestion asynchrone d'images avec cache)

Les packages externes sont installés avec **Swift Package Manager**.

### User story 1

Pour cette vue simple, un `ViewController` (ici `HomeViewController`) va afficher un gif aléatoire. La vue modèle `RandomGIFViewModel` va effectuer un appel API de **Giphy** et récupérer l'URL d'un GIF aléatoire. Par le biais du data binding, la vue va afficher le GIF avec l'aide de **Kingfisher**.

<img src="https://github.com/Kous92/Test-technique-iOS-Netgem/blob/main/Screenshots/US1iPhone.png" width="250">
<img src="https://github.com/Kous92/Test-technique-iOS-Netgem/blob/main/Screenshots/US1iPad.png" width="450">
