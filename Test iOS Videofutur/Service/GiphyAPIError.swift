//
//  GiphyAPIError.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

enum GiphyAPIError: String, Error {
    case badRequest = "Erreur 400: Erreur 400: Paramètres manquants dans la requête."
    case forbidden = "Erreur 403: Requête non autorisée (potentiellement un problème au niveau de la clé d'API)."
    case notFound = "Erreur 404: Aucun contenu disponible."
    case tooManyRequests = "Erreur 429: Trop de requêtes ont été effectuées dans un laps de temps. Veuillez réessayer ultérieurement."
    case serverError = "Erreur 500: Erreur serveur."
    case apiError = "Une erreur est survenue."
    case invalidURL = "Erreur: URL invalide."
    case networkError = "Une erreur est survenue, pas de connexion Internet."
    case decodeError = "Une erreur est survenue au décodage des données téléchargées."
    case downloadError = "Une erreur est survenue au téléchargement des données."
    case unknown = "Erreur inconnue."
}
