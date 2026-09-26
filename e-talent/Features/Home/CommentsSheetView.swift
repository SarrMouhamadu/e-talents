import SwiftUI

public struct CommentsSheetView: View {
    public let post: Post
    @State private var commentText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    public init(post: Post) {
        self.post = post
    }
    
    private var currentPost: Post {
        MockDataService.shared.posts.first(where: { $0.id == post.id }) ?? post
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Aperçu du post commenté
                    HStack(spacing: ETSpacing.small) {
                        ETAvatar(name: post.authorName, size: .small, isVerified: post.isAuthorVerified)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(post.authorName)
                                .font(ETTypography.subheadlineBold)
                                .foregroundColor(ETColors.pureWhite)
                            Text(post.content)
                                .font(ETTypography.caption)
                                .foregroundColor(ETColors.secondaryText)
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                    .padding(ETSpacing.standard)
                    .background(ETColors.darkSurface.opacity(0.6))
                    
                    Divider().overlay(ETColors.borderGray.opacity(0.12))
                    
                    // Liste des commentaires
                    if currentPost.comments.isEmpty {
                        Spacer()
                        ETEmptyState(
                            icon: "bubble.left",
                            title: "Aucun commentaire",
                            description: "Soyez le premier à encourager ou à commenter cette action !"
                        )
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: ETSpacing.standard) {
                                ForEach(currentPost.comments) { comment in
                                    HStack(alignment: .top, spacing: ETSpacing.small) {
                                        ETAvatar(name: comment.authorName, size: .small, isVerified: comment.isVerified)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack(spacing: ETSpacing.xxSmall) {
                                                Text(comment.authorName)
                                                    .font(ETTypography.subheadlineBold)
                                                    .foregroundColor(ETColors.pureWhite)
                                                
                                                if comment.isVerified {
                                                    Image(systemName: "checkmark.seal.fill")
                                                        .font(.system(size: 11))
                                                        .foregroundColor(ETColors.primaryOrange)
                                                }
                                                
                                                Spacer()
                                                
                                                Text(comment.timeAgo)
                                                    .font(ETTypography.caption)
                                                    .foregroundColor(ETColors.secondaryText)
                                            }
                                            
                                            Text(comment.text)
                                                .font(ETTypography.body)
                                                .foregroundColor(ETColors.pureWhite)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                    .padding(.horizontal, ETSpacing.standard)
                                    .padding(.vertical, 4)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityLabel("\(comment.authorName), \(comment.text), \(comment.timeAgo)")
                                }
                            }
                            .padding(.vertical, ETSpacing.standard)
                        }
                    }
                    
                    Divider().overlay(ETColors.borderGray.opacity(0.12))
                    
                    // Barre d'écriture du commentaire
                    HStack(spacing: ETSpacing.small) {
                        TextField(
                            "",
                            text: $commentText,
                            prompt: Text("Ajouter un commentaire...").foregroundColor(ETColors.secondaryText)
                        )
                        .font(ETTypography.body)
                        .foregroundColor(ETColors.pureWhite)
                        .padding(.horizontal, ETSpacing.standard)
                        .frame(height: 44)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.pill)
                        
                        let isCommentEmpty = commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        
                        Button(action: sendComment) {
                            Text("Publier")
                                .font(ETTypography.button)
                                .foregroundColor(isCommentEmpty ? ETColors.secondaryText : ETColors.pureBlack)
                                .padding(.horizontal, 14)
                                .frame(height: 44)
                                .background(isCommentEmpty ? ETColors.darkSurface : ETColors.primaryOrange)
                                .cornerRadius(ETRadius.pill)
                        }
                        .disabled(isCommentEmpty)
                        .accessibilityLabel("Envoyer le commentaire")
                    }
                    .padding(.horizontal, ETSpacing.standard)
                    .padding(.vertical, ETSpacing.small)
                    .background(ETColors.darkSurface.opacity(0.5))
                }
            }
            .navigationTitle("Commentaires (\(currentPost.commentsCount))")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                    .font(ETTypography.button)
                    .foregroundColor(ETColors.primaryOrange)
                    .frame(minWidth: 44, minHeight: 44)
                    .contentShape(Rectangle())
                }
            }
        }
    }
    
    private func sendComment() {
        let text = commentText
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        MockDataService.shared.addComment(to: post.id, text: text)
        commentText = ""
    }
}
