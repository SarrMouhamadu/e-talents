import SwiftUI

/// Design System - Palette de couleurs officielle E-Talent
public enum ETColors {
    // MARK: - Couleurs Principales
    /// Orange signature (#FF6A00) - Couleur d'action, accents et états actifs
    public static let primaryOrange = Color(hex: "#FF6A00")
    
    /// Noir profond (#0B0B0D) - Fonds sombres, contrastes forts
    public static let pureBlack = Color(hex: "#0B0B0D")
    
    /// Dark (#151518) - Cartes sombres, barres et éléments secondaires
    public static let darkSurface = Color(hex: "#151518")
    
    /// Blanc (#FFFFFF) - Texte sur fond sombre, cartes en mode clair
    public static let pureWhite = Color(hex: "#FFFFFF")
    
    /// Gris clair (#F5F5F5) - Fonds légers, capsules inactives
    public static let lightGray = Color(hex: "#F5F5F5")
    
    /// Gris bordure (#D9D9D9) - Séparateurs et contours discrets
    public static let borderGray = Color(hex: "#D9D9D9")
    
    /// Gris texte secondaire (#737373) - Sous-titres, dates, métadonnées
    public static let secondaryText = Color(hex: "#737373")
    
    // MARK: - Accents Identitaires Sénégal (utilisés avec parcimonie)
    public static let senegalGreen = Color(hex: "#00853F")
    public static let senegalYellow = Color(hex: "#FDEF42")
    public static let senegalRed = Color(hex: "#E31B23")
    
    // MARK: - Couleurs Sémantiques & États
    public static let background = pureBlack
    public static let cardBackground = darkSurface
    public static let textPrimary = pureWhite
    public static let textSecondary = secondaryText
    public static let textOnOrange = pureBlack
    public static let textOnDark = pureWhite
    public static let success = Color(hex: "#22C55E")
    public static let error = Color(hex: "#EF4444")
}
