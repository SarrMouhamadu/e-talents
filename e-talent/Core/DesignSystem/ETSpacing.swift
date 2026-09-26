import SwiftUI

/// Design System - Grille d'espacement standard pour E-Talent (base 4)
public enum ETSpacing {
    /// 4pt - Micro espacement (entre icône et texte condensé)
    public static let xxSmall: CGFloat = 4
    
    /// 8pt - Espacement serré (entre éléments d'un même groupe)
    public static let xSmall: CGFloat = 8
    
    /// 12pt - Espacement moyen (padding interne compact)
    public static let small: CGFloat = 12
    
    /// 16pt - Espacement standard (padding horizontal d'écran, marges de cartes)
    public static let standard: CGFloat = 16
    
    /// 20pt - Espacement intermédiaire
    public static let medium: CGFloat = 20
    
    /// 24pt - Espacement des grandes sections
    public static let large: CGFloat = 24
    
    /// 32pt - Espacement aéré (entre blocs distincts)
    public static let xLarge: CGFloat = 32
    
    /// 40pt - Espacement généreux
    public static let xxLarge: CGFloat = 40
    
    /// 48pt - Espacement d'en-têtes et de séparations majeures
    public static let xxxLarge: CGFloat = 48
}
