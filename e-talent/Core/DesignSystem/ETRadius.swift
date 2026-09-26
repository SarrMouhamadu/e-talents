import SwiftUI

/// Design System - Rayons d'angles (Corner Radius) pour E-Talent
public enum ETRadius {
    /// 8pt - Petits éléments, puces compactes
    public static let small: CGFloat = 8
    
    /// 12pt - Boutons et images standards
    public static let button: CGFloat = 12
    
    /// 12-16pt - Rayon pour les images de média
    public static let media: CGFloat = 14
    
    /// 16pt - Cartes, conteneurs et dialogues
    public static let card: CGFloat = 16
    
    /// 24pt - En-tête des fenêtres modales / Bottom Sheets
    public static let bottomSheet: CGFloat = 24
    
    /// Rayon pilule / circulaire complet
    public static let pill: CGFloat = 999
}
