import SwiftUI

/// Design System - Typographie Apple System pour E-Talent
public enum ETTypography {
    /// Grand titre d'écran (28-30pt, Bold)
    public static let largeTitle: Font = .system(size: 28, weight: .bold, design: .default)
    
    /// Titre de section ou d'en-tête (22-24pt, Bold)
    public static let title: Font = .system(size: 22, weight: .bold, design: .default)
    
    /// Titre de carte ou d'élément fort (18-20pt, Semibold)
    public static let headline: Font = .system(size: 18, weight: .semibold, design: .default)
    
    /// Titre secondaire / nom d'utilisateur (16-17pt, Semibold)
    public static let subheadlineBold: Font = .system(size: 16, weight: .semibold, design: .default)
    
    /// Texte courant standard (15-16pt, Regular)
    public static let body: Font = .system(size: 15, weight: .regular, design: .default)
    
    /// Texte de bouton ou action (15-16pt, Semibold)
    public static let button: Font = .system(size: 16, weight: .semibold, design: .default)
    
    /// Informations secondaires / sous-titres (14-15pt, Regular)
    public static let callout: Font = .system(size: 14, weight: .regular, design: .default)
    
    /// Badges et puces (13-14pt, Medium)
    public static let badge: Font = .system(size: 13, weight: .medium, design: .default)
    
    /// Horodatages et métadonnées courtes (12-13pt, Regular)
    public static let caption: Font = .system(size: 12, weight: .regular, design: .default)
}
