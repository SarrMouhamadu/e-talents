import SwiftUI

public struct ETPostCard: View {
    public let post: Post
    public var onLikeTapped: (() -> Void)?
    public var onCommentTapped: (() -> Void)?
    public var onBookmarkTapped: (() -> Void)?
    public var onAuthorTapped: (() -> Void)?
    
    public init(
        post: Post,
        onLikeTapped: (() -> Void)? = nil,
        onCommentTapped: (() -> Void)? = nil,
        onBookmarkTapped: (() -> Void)? = nil,
        onAuthorTapped: (() -> Void)? = nil
    ) {
        self.post = post
        self.onLikeTapped = onLikeTapped
        self.onCommentTapped = onCommentTapped
        self.onBookmarkTapped = onBookmarkTapped
        self.onAuthorTapped = onAuthorTapped
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: ETSpacing.small) {
            // MARK: - En-tête (Auteur, Rôle, Club, Temps)
            HStack(spacing: ETSpacing.small) {
                Button(action: { onAuthorTapped?() }) {
                    HStack(spacing: ETSpacing.small) {
                        ETAvatar(name: post.authorName, size: .small, isVerified: post.isAuthorVerified)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: ETSpacing.xxSmall) {
                                Text(post.authorName)
                                    .font(ETTypography.subheadlineBold)
                                    .foregroundColor(ETColors.pureWhite)
                                
                                if post.isAuthorVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(ETColors.primaryOrange)
                                }
                            }
                            
                            HStack(spacing: ETSpacing.xxSmall) {
                                if let club = post.authorClub {
                                    Text(club)
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.primaryOrange)
                                    Text("•")
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.secondaryText)
                                }
                                Text(post.timeAgo)
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.secondaryText)
                            }
                        }
                    }
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Profil de \(post.authorName)")
                
                Spacer()
                
                Menu {
                    Button("Partager", action: {})
                    Button("Signaler", role: .destructive, action: {})
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16))
                        .foregroundColor(ETColors.secondaryText)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .accessibilityLabel("Options de la publication")
            }
            
            // MARK: - Texte de la publication
            if !post.content.isEmpty {
                Text(post.content)
                    .font(ETTypography.body)
                    .foregroundColor(ETColors.pureWhite)
                    .lineSpacing(3)
            }
            
            // MARK: - Média (Photo ou Vidéo basketball)
            if post.mediaType != .none {
                ZStack(alignment: .bottomLeading) {
                    if let data = post.imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(post.mediaAspectRatio, contentMode: .fit)
                            .clipped()
                            .cornerRadius(ETRadius.media)
                            .overlay(
                                RoundedRectangle(cornerRadius: ETRadius.media)
                                    .stroke(ETColors.borderGray.opacity(0.15), lineWidth: 1)
                            )
                    } else {
                        RoundedRectangle(cornerRadius: ETRadius.media)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "#1F1F24"), Color(hex: "#121215")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .aspectRatio(post.mediaAspectRatio, contentMode: .fit)
                            .overlay(
                                VStack(spacing: ETSpacing.small) {
                                    Image(systemName: post.mediaType == .video ? "play.circle.fill" : "basketball.fill")
                                        .font(.system(size: 42))
                                        .foregroundColor(ETColors.primaryOrange.opacity(0.85))
                                    
                                    if let caption = post.mediaCaption {
                                        Text(caption)
                                            .font(ETTypography.caption)
                                            .foregroundColor(ETColors.secondaryText)
                                    }
                                }
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: ETRadius.media)
                                    .stroke(ETColors.borderGray.opacity(0.1), lineWidth: 1)
                            )
                    }
                    
                    if post.mediaType == .video {
                        HStack(spacing: ETSpacing.xxSmall) {
                            Image(systemName: "play.fill")
                                .font(.system(size: 10))
                            Text("Highlight Vidéo")
                                .font(ETTypography.caption)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(ETColors.pureWhite)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(ETColors.pureBlack.opacity(0.75))
                        .cornerRadius(ETRadius.small)
                        .padding(ETSpacing.small)
                    }
                }
            }
            
            // MARK: - Actions (Like, Comment, Bookmark)
            HStack(spacing: ETSpacing.large) {
                // Like Button
                Button(action: { onLikeTapped?() }) {
                    HStack(spacing: ETSpacing.xxSmall) {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 18))
                            .foregroundColor(post.isLiked ? ETColors.primaryOrange : ETColors.secondaryText)
                        Text("\(post.likesCount)")
                            .font(ETTypography.caption)
                            .foregroundColor(post.isLiked ? ETColors.primaryOrange : ETColors.secondaryText)
                    }
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Aimer la publication, \(post.likesCount) mentions j'aime")
                
                // Comment Button
                Button(action: { onCommentTapped?() }) {
                    HStack(spacing: ETSpacing.xxSmall) {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 17))
                            .foregroundColor(ETColors.secondaryText)
                        Text("\(post.commentsCount)")
                            .font(ETTypography.caption)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Commenter, \(post.commentsCount) commentaires")
                
                Spacer()
                
                // Bookmark Button
                Button(action: { onBookmarkTapped?() }) {
                    Image(systemName: post.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 17))
                        .foregroundColor(post.isBookmarked ? ETColors.primaryOrange : ETColors.secondaryText)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(post.isBookmarked ? "Retirer des signets" : "Enregistrer la publication")
            }
        }
        .padding(ETSpacing.standard)
        .background(ETColors.darkSurface)
        .cornerRadius(ETRadius.card)
        .overlay(
            RoundedRectangle(cornerRadius: ETRadius.card)
                .stroke(ETColors.borderGray.opacity(0.12), lineWidth: 1)
        )
    }
}
