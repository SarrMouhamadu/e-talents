import Foundation

public enum MockData {
    // MARK: - Joueurs
    public static let samplePlayers: [Player] = [
        Player(
            id: "player_1",
            name: "Ibrahima Fall",
            position: .pointGuard,
            age: 18,
            heightCm: 188,
            city: "Dakar",
            clubName: "AS Douanes",
            isAvailable: false,
            isVerified: true,
            bio: "Meneur de jeu dynamique et altruiste. Champion National U18 (2025). Focus sur le tir à 3 points et la vision de jeu.",
            photosCount: 14,
            videosCount: 8,
            followersCount: 1240,
            followingCount: 180
        ),
        Player(
            id: "player_2",
            name: "Mamadou Sarr",
            position: .powerForward,
            age: 19,
            heightCm: 204,
            city: "Thiès",
            clubName: nil,
            isAvailable: true,
            isVerified: true,
            bio: "Ailier fort athlétique, excellente présence au rebond défensif et offensif. À la recherche d'un club ambitieux pour la saison.",
            photosCount: 22,
            videosCount: 12,
            followersCount: 2310,
            followingCount: 310
        ),
        Player(
            id: "player_3",
            name: "Moussa Ndiaye",
            position: .shootingGuard,
            age: 17,
            heightCm: 194,
            city: "Pikine",
            clubName: "AS Pikine",
            isAvailable: false,
            isVerified: false,
            bio: "Shooter d'élite et défenseur sur l'homme. Travail acharné au quotidien pour franchir un palier.",
            photosCount: 9,
            videosCount: 5,
            followersCount: 890,
            followingCount: 140
        ),
        Player(
            id: "player_4",
            name: "Cheikh Diop",
            position: .center,
            age: 20,
            heightCm: 211,
            city: "Saint-Louis",
            clubName: nil,
            isAvailable: true,
            isVerified: false,
            bio: "Pivot d'envergure 2m18, protecteur de cercle et finisseur près du panier. Disponible pour détection et essais.",
            photosCount: 17,
            videosCount: 15,
            followersCount: 3450,
            followingCount: 220
        ),
        Player(
            id: "player_5",
            name: "Babacar Diallo",
            position: .smallForward,
            age: 18,
            heightCm: 199,
            city: "Ziguinchor",
            clubName: "DUC",
            isAvailable: false,
            isVerified: true,
            bio: "Ailier complet, jeu en transition rapide et solide défense d'équipe.",
            photosCount: 11,
            videosCount: 6,
            followersCount: 1580,
            followingCount: 290
        )
    ]
    
    // MARK: - Clubs
    public static let sampleClubs: [Club] = [
        Club(
            id: "club_1",
            name: "AS Douanes",
            city: "Dakar",
            division: "National 1 Masculin",
            isVerified: true,
            description: "Club historique de basketball sénégalais, multiple champion du Sénégal et représentant en Basketball Africa League (BAL).",
            playersCount: 16,
            followersCount: 14200
        ),
        Club(
            id: "club_2",
            name: "AS Pikine Basket",
            city: "Pikine, Dakar",
            division: "National 1",
            isVerified: true,
            description: "Centre de formation et club phare de la banlieue dakaroise, réputé pour son vivier de jeunes talents.",
            playersCount: 20,
            followersCount: 8900
        ),
        Club(
            id: "club_3",
            name: "Dakar Université Club (DUC)",
            city: "Dakar",
            division: "National 1",
            isVerified: true,
            description: "Institution universitaire sportive formant l'élite académique et athlétique du basket sénégalais.",
            playersCount: 18,
            followersCount: 11200
        ),
        Club(
            id: "club_4",
            name: "US Rail Thiès",
            city: "Thiès",
            division: "National 2",
            isVerified: false,
            description: "Club formateur de la région de Thiès, orienté détection et développement des jeunes espoirs.",
            playersCount: 15,
            followersCount: 4200
        )
    ]
    
    // MARK: - Publications Feed
    public static let samplePosts: [Post] = [
        Post(
            id: "post_1",
            authorId: "player_1",
            authorName: "Ibrahima Fall",
            authorHandle: "@ibrahima.fall",
            authorRole: "Joueur",
            authorClub: "AS Douanes",
            authorPosition: "Meneur",
            isAuthorVerified: true,
            timeAgo: "Il y a 2h",
            content: "Séance matinale au Stadium Marius Ndiaye. Focus sur le step-back 3pts et la prise de décision sur pick-and-roll. Toujours prêt pour le prochain match ! 🏀🇸🇳",
            mediaType: .video,
            mediaAspectRatio: 0.8,
            mediaCaption: "Session Workout • Marius Ndiaye",
            likesCount: 142,
            commentsCount: 18,
            isLiked: true,
            isBookmarked: false,
            comments: [
                PostComment(authorName: "Moussa Ndiaye", authorRole: "Joueur", text: "Propre le step-back bro ! 🔥🇸🇳", timeAgo: "Il y a 1h"),
                PostComment(authorName: "Coach Babacar", authorRole: "Coach", text: "Très bon travail sur les appuis, continue comme ça.", timeAgo: "Il y a 45 min", isVerified: true)
            ]
        ),
        Post(
            id: "post_2",
            authorId: "club_1",
            authorName: "AS Douanes",
            authorHandle: "@asdouanes.basket",
            authorRole: "Club",
            authorClub: nil,
            authorPosition: "National 1",
            representativeName: "Coach Pabi Guèye",
            representativeRole: "Entraîneur Principal",
            isAuthorVerified: true,
            timeAgo: "Il y a 5h",
            content: "Victoire importante ce week-end (78-65) ! Félicitations à toute l'équipe et mention spéciale à nos jeunes pousses pour leur engagement défensif irréprochable.",
            mediaType: .photo,
            mediaAspectRatio: 0.8,
            mediaCaption: "Match Day Highlights",
            likesCount: 384,
            commentsCount: 32,
            isLiked: false,
            isBookmarked: true,
            comments: [
                PostComment(authorName: "Ibrahima Fall", authorRole: "Joueur", text: "Fierté de porter ce maillot ! 🏀", timeAgo: "Il y a 4h", isVerified: true),
                PostComment(authorName: "Cheikh Diop", authorRole: "Joueur", text: "Grosse performance d'équipe !", timeAgo: "Il y a 3h")
            ]
        ),
        Post(
            id: "post_3",
            authorId: "player_2",
            authorName: "Mamadou Sarr",
            authorHandle: "@mamadou.sarr",
            authorRole: "Joueur",
            authorClub: nil,
            authorPosition: "Ailier fort",
            isAuthorVerified: true,
            timeAgo: "Il y a 1j",
            content: "Highlights du tournoi de Thiès le week-end dernier : 22 points, 14 rebonds et 4 contres. Je suis disponible et ouvert aux opportunités pour la nouvelle saison.",
            mediaType: .video,
            mediaAspectRatio: 1.77,
            mediaCaption: "Tournoi Thiès 2026 • Mixtape",
            likesCount: 267,
            commentsCount: 45,
            isLiked: false,
            isBookmarked: false,
            comments: [
                PostComment(authorName: "Coach Babacar", authorRole: "Coach", text: "Intéressant profil athlétique. Viens nous voir mardi.", timeAgo: "Il y a 18h", isVerified: true)
            ]
        ),
        Post(
            id: "post_4",
            authorId: "player_3",
            authorName: "Moussa Ndiaye",
            authorHandle: "@moussa.ndiaye",
            authorRole: "Joueur",
            authorClub: "AS Pikine",
            authorPosition: "Arrière",
            isAuthorVerified: false,
            timeAgo: "Il y a 2j",
            content: "Le travail dans l'ombre paye toujours. Merci aux supporters de Pikine pour la force à chaque entraînement !",
            mediaType: .photo,
            mediaAspectRatio: 0.8,
            mediaCaption: "Centre d'entraînement Pikine",
            likesCount: 98,
            commentsCount: 12,
            isLiked: false,
            isBookmarked: false,
            comments: []
        )
    ]
    
    // MARK: - Conversations
    public static let sampleConversations: [Conversation] = [
        Conversation(
            id: "conv_1",
            participantName: "Coach Babacar (AS Douanes)",
            participantRole: "Coach",
            participantClub: "AS Douanes",
            isVerified: true,
            lastMessage: "Salut Mamadou, tes derniers highlights sont impressionnants. Es-tu dispo pour un échange mardi ?",
            timeAgo: "14:30",
            unreadCount: 2
        ),
        Conversation(
            id: "conv_2",
            participantName: "Ibrahima Fall",
            participantRole: "Joueur",
            participantClub: "AS Douanes",
            isVerified: true,
            lastMessage: "Force pour ton tournoi ce week-end mon frère !",
            timeAgo: "Hier",
            unreadCount: 0
        ),
        Conversation(
            id: "conv_3",
            participantName: "AS Pikine Basket",
            participantRole: "Club",
            participantClub: nil,
            isVerified: true,
            lastMessage: "Nous organisons des détections ouvertes samedi prochain.",
            timeAgo: "23 sept.",
            unreadCount: 0
        )
    ]
    
    // MARK: - Notifications
    public static let sampleNotifications: [NotificationItem] = [
        NotificationItem(
            id: "notif_1",
            type: .scout,
            actorName: "AS Douanes",
            actorRole: "Club",
            actionDescription: "a consulté votre profil sportif",
            timeAgo: "Il y a 10 min",
            isRead: false
        ),
        NotificationItem(
            id: "notif_2",
            type: .like,
            actorName: "Ibrahima Fall",
            actorRole: "Joueur",
            actionDescription: "a aimé votre publication vidéo",
            timeAgo: "Il y a 1h",
            isRead: false
        ),
        NotificationItem(
            id: "notif_3",
            type: .follow,
            actorName: "Moussa Ndiaye",
            actorRole: "Joueur",
            actionDescription: "a commencé à vous suivre",
            timeAgo: "Il y a 3h",
            isRead: true
        ),
        NotificationItem(
            id: "notif_4",
            type: .comment,
            actorName: "Cheikh Diop",
            actorRole: "Joueur",
            actionDescription: "a commenté : \"Gros dunk bro ! Continue comme ça 🇸🇳🔥\"",
            timeAgo: "Hier",
            isRead: true
        )
    ]
}
