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
            avatarUrl: "player_ibrahima_fall",
            photosCount: 14,
            videosCount: 8,
            followersCount: 1240,
            followingCount: 180
        ),
        Player(
            id: "player_6",
            name: "Léna Timéra",
            position: .pointGuard,
            age: 19,
            heightCm: 172,
            city: "Dakar",
            clubName: "DUC Basket",
            isAvailable: false,
            isVerified: true,
            bio: "Meneuse vive, clutch shooter et chef d'orchestre sur le terrain. Sélectionnée en équipe nationale U19. Focus sur le leadership et la défense agressive.",
            avatarUrl: "player_lena_timera",
            photosCount: 18,
            videosCount: 10,
            followersCount: 3120,
            followingCount: 240
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
            avatarUrl: "player_mamadou_sarr",
            photosCount: 22,
            videosCount: 12,
            followersCount: 2310,
            followingCount: 310
        ),
        Player(
            id: "player_7",
            name: "Yacine Diop",
            position: .shootingGuard,
            age: 21,
            heightCm: 178,
            city: "Dakar",
            clubName: "ASC Ville de Dakar",
            isAvailable: false,
            isVerified: true,
            bio: "Arrière scoreuse polyvalente, championne du Sénégal. Impact immédiat en transition, tir extérieur et combativité défensive.",
            avatarUrl: "player_yacine_diop",
            photosCount: 29,
            videosCount: 14,
            followersCount: 4560,
            followingCount: 320
        ),
        Player(
            id: "player_10",
            name: "Youssou Ndoye",
            position: .center,
            age: 23,
            heightCm: 213,
            city: "Dakar",
            clubName: "AS Douanes",
            isAvailable: false,
            isVerified: true,
            bio: "Pivot d'envergure internationale, pilier de la raquette des Lions du Sénégal. Rebond, protection du cercle et jeu au poste bas.",
            avatarUrl: "player_youssou_ndoye",
            photosCount: 35,
            videosCount: 18,
            followersCount: 6890,
            followingCount: 410
        ),
        Player(
            id: "player_8",
            name: "Fatou Diagne",
            position: .center,
            age: 20,
            heightCm: 193,
            city: "Saint-Louis",
            clubName: "SLBC Saint-Louis",
            isAvailable: true,
            isVerified: true,
            bio: "Pivot dominante de 1m93, intimidatrice dans la peinture et rebondeuse d'élite. Prête pour de nouveaux défis nationaux et internationaux.",
            avatarUrl: "player_fatou_diagne",
            photosCount: 16,
            videosCount: 9,
            followersCount: 2180,
            followingCount: 195
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
            avatarUrl: "player_moussa_ndiaye",
            photosCount: 9,
            videosCount: 5,
            followersCount: 890,
            followingCount: 140
        ),
        Player(
            id: "player_9",
            name: "Astou Traoré",
            position: .powerForward,
            age: 22,
            heightCm: 185,
            city: "Thiès",
            clubName: "US Rail Thiès",
            isAvailable: false,
            isVerified: true,
            bio: "Ailière forte moderne, capable d'écarter le jeu à 3 points et de finir fort au cercle. Expérience en compétitions continentales.",
            avatarUrl: "player_astou_traore",
            photosCount: 24,
            videosCount: 11,
            followersCount: 3890,
            followingCount: 260
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
            avatarUrl: "player_cheikh_diop",
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
            avatarUrl: "player_babacar_diallo",
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
            authorId: "player_6",
            authorName: "Léna Timéra",
            authorHandle: "@lena.timera",
            authorRole: "Joueur",
            authorClub: "DUC Basket",
            authorPosition: "Meneuse",
            isAuthorVerified: true,
            timeAgo: "Il y a 2h",
            content: "Séance intense avec les Lionnes au Stadium Marius Ndiaye ! Focus absolu sur la circulation du ballon et les finitions rapides en transition. On continue de monter en puissance ! 🏀🇸🇳🔥",
            mediaType: .photo,
            mediaAspectRatio: 1.25,
            mediaCaption: "Session d'entraînement • Stadium Marius Ndiaye",
            likesCount: 248,
            commentsCount: 24,
            isLiked: true,
            isBookmarked: false,
            comments: [
                PostComment(authorName: "Yacine Diop", authorRole: "Joueur", text: "Ensemble ma soeur, très propre ! 🔥🇸🇳", timeAgo: "Il y a 1h", isVerified: true),
                PostComment(authorName: "Coach Babacar", authorRole: "Coach", text: "Excellente intensité sur le repli, bravo.", timeAgo: "Il y a 45 min", isVerified: true)
            ],
            authorAvatarUrl: "player_lena_timera",
            imageName: "media_lionnes_duo"
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
            timeAgo: "Il y a 4h",
            content: "Victoire de caractère ce week-end (78-65) face à une équipe très physique. Félicitations à nos guerriers et mention spéciale à nos jeunes pousses pour leur rigueur défensive !",
            mediaType: .photo,
            mediaAspectRatio: 1.45,
            mediaCaption: "Championnat National • Victoire 78-65",
            likesCount: 412,
            commentsCount: 38,
            isLiked: false,
            isBookmarked: true,
            comments: [
                PostComment(authorName: "Ibrahima Fall", authorRole: "Joueur", text: "Fierté de porter ce maillot ! 🏀🇸🇳", timeAgo: "Il y a 3h", isVerified: true),
                PostComment(authorName: "Youssou Ndoye", authorRole: "Joueur", text: "Grosse performance collective les gars !", timeAgo: "Il y a 2h", isVerified: true)
            ],
            authorAvatarUrl: nil,
            imageName: "media_mali_match"
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
            timeAgo: "Il y a 8h",
            content: "Highlights du tournoi régional à Thiès : 22 points, 14 rebonds et 4 contres ! Toujours affamé et disponible pour de nouveaux challenges cette saison. 🇸🇳💥",
            mediaType: .photo,
            mediaAspectRatio: 1.0,
            mediaCaption: "Tournoi Thiès 2026 • Fastbreak Dunk",
            likesCount: 315,
            commentsCount: 42,
            isLiked: false,
            isBookmarked: false,
            comments: [
                PostComment(authorName: "Coach Babacar", authorRole: "Coach", text: "Superbe envergure et gros timing au contre. Viens nous voir mardi.", timeAgo: "Il y a 5h", isVerified: true),
                PostComment(authorName: "Cheikh Diop", authorRole: "Joueur", text: "Gros dunk bro ! Continue comme ça 🇸🇳🔥", timeAgo: "Il y a 4h")
            ],
            authorAvatarUrl: "player_mamadou_sarr",
            imageName: "media_dunk_highlight"
        ),
        Post(
            id: "post_4",
            authorId: "player_7",
            authorName: "Yacine Diop",
            authorHandle: "@yacine.diop",
            authorRole: "Joueur",
            authorClub: "ASC Ville de Dakar",
            authorPosition: "Ailière",
            isAuthorVerified: true,
            timeAgo: "Il y a 1j",
            content: "Une grosse bataille sur le parquet ce soir ! Victoire précieuse au bout de la prolongation. Merci à tous les supporters venus donner de la voix ! 🇸🇳🙌🏾",
            mediaType: .photo,
            mediaAspectRatio: 1.35,
            mediaCaption: "Playoffs National 1 Féminin",
            likesCount: 520,
            commentsCount: 56,
            isLiked: true,
            isBookmarked: false,
            comments: [
                PostComment(authorName: "Léna Timéra", authorRole: "Joueur", text: "MVP sans discussion ! 👑🏀", timeAgo: "Il y a 22h", isVerified: true)
            ],
            authorAvatarUrl: "player_yacine_diop",
            imageName: "media_afrobasket_action"
        ),
        Post(
            id: "post_5",
            authorId: "player_10",
            authorName: "Youssou Ndoye",
            authorHandle: "@youssou.ndoye",
            authorRole: "Joueur",
            authorClub: "AS Douanes",
            authorPosition: "Pivot",
            isAuthorVerified: true,
            timeAgo: "Il y a 2j",
            content: "L'honneur suprême de défendre les couleurs nationales. Chaque minute passée sur le terrain est une bénédiction. Ensemble pour le Sénégal ! 🦁🇸🇳",
            mediaType: .photo,
            mediaAspectRatio: 1.5,
            mediaCaption: "Lions du Sénégal • Fierté Nationale",
            likesCount: 780,
            commentsCount: 64,
            isLiked: false,
            isBookmarked: true,
            comments: [
                PostComment(authorName: "Ibrahima Fall", authorRole: "Joueur", text: "Le grand frère et modèle pour toute notre génération ! 🙏🏾🇸🇳", timeAgo: "Il y a 1j", isVerified: true)
            ],
            authorAvatarUrl: "player_youssou_ndoye",
            imageName: "media_lions_anthem"
        ),
        Post(
            id: "post_6",
            authorId: "player_1",
            authorName: "Ibrahima Fall",
            authorHandle: "@ibrahima.fall",
            authorRole: "Joueur",
            authorClub: "AS Douanes",
            authorPosition: "Meneur",
            isAuthorVerified: true,
            timeAgo: "Il y a 3j",
            content: "Retour aux sources sur les terrains de quartier. C'est ici que la passion est née, sous le soleil de Dakar. Le basket c'est plus qu'un sport, c'est une famille. 🏀☀️🇸🇳",
            mediaType: .photo,
            mediaAspectRatio: 1.25,
            mediaCaption: "Streetball Dakar • Racines",
            likesCount: 195,
            commentsCount: 17,
            isLiked: false,
            isBookmarked: false,
            comments: [],
            authorAvatarUrl: "player_ibrahima_fall",
            imageName: "media_outdoor_match"
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
