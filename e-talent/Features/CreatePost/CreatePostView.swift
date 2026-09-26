import SwiftUI

public struct CreatePostView: View {
    @State private var postContent: String = ""
    @State private var selectedMediaType: PostMediaType = .video
    @State private var mediaCaption: String = "Workout Session • Marius Ndiaye"
    @State private var isSubmitting: Bool = false
    @State private var isSuccess: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: ETSpacing.standard) {
                        // Auteur info
                        HStack(spacing: ETSpacing.small) {
                            ETAvatar(name: "Mamadou Sarr", size: .medium, isVerified: true)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Mamadou Sarr")
                                    .font(ETTypography.subheadlineBold)
                                    .foregroundColor(ETColors.pureWhite)
                                
                                Text("Ailier fort • Thiès")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.secondaryText)
                            }
                        }
                        
                        // Text Editor
                        ZStack(alignment: .topLeading) {
                            if postContent.isEmpty {
                                Text("Partagez un temps fort, un entraînement, une performance...")
                                    .font(ETTypography.body)
                                    .foregroundColor(ETColors.secondaryText)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }
                            
                            TextEditor(text: $postContent)
                                .font(ETTypography.body)
                                .foregroundColor(ETColors.pureWhite)
                                .scrollContentBackground(.hidden)
                                .frame(minHeight: 120)
                        }
                        .padding(ETSpacing.small)
                        .background(ETColors.darkSurface)
                        .cornerRadius(ETRadius.card)
                        
                        // Choix du média
                        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                            Text("TYPE DE MÉDIA")
                                .font(ETTypography.caption)
                                .fontWeight(.bold)
                                .foregroundColor(ETColors.secondaryText)
                            
                            HStack(spacing: ETSpacing.small) {
                                mediaOptionButton(
                                    title: "Vidéo Highlight",
                                    icon: "play.circle.fill",
                                    type: .video
                                )
                                
                                mediaOptionButton(
                                    title: "Photo",
                                    icon: "photo.fill",
                                    type: .photo
                                )
                                
                                mediaOptionButton(
                                    title: "Texte seul",
                                    icon: "text.alignleft",
                                    type: .none
                                )
                            }
                        }
                        
                        // Aperçu du média sélectionné
                        if selectedMediaType != .none {
                            VStack(alignment: .leading, spacing: ETSpacing.xxSmall) {
                                Text("APERÇU DU CONTENU")
                                    .font(ETTypography.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(ETColors.secondaryText)
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: ETRadius.media)
                                        .fill(ETColors.darkSurface)
                                        .aspectRatio(selectedMediaType == .video ? 1.77 : 0.8, contentMode: .fit)
                                        .overlay(
                                            VStack(spacing: ETSpacing.small) {
                                                Image(systemName: selectedMediaType == .video ? "video.badge.plus" : "photo.badge.plus")
                                                    .font(.system(size: 38))
                                                    .foregroundColor(ETColors.primaryOrange)
                                                
                                                Text(selectedMediaType == .video ? "Vidéo sélectionnée (Format 16:9)" : "Photo sélectionnée (Format 4:5)")
                                                    .font(ETTypography.caption)
                                                    .foregroundColor(ETColors.pureWhite)
                                            }
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: ETRadius.media)
                                                .stroke(ETColors.borderGray.opacity(0.15), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        
                        // Message Succès
                        if isSuccess {
                            HStack(spacing: ETSpacing.small) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(ETColors.success)
                                Text("Publication mise en ligne avec succès !")
                                    .font(ETTypography.body)
                                    .foregroundColor(ETColors.success)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ETColors.success.opacity(0.12))
                            .cornerRadius(ETRadius.button)
                        }
                        
                        // Bouton de publication
                        ETButton(
                            "Publier sur E-Talent",
                            icon: "paperplane.fill",
                            style: .primary,
                            size: .large,
                            isLoading: isSubmitting
                        ) {
                            submitPost()
                        }
                        .disabled(postContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.top, ETSpacing.small)
                    }
                    .padding(ETSpacing.standard)
                }
            }
            .navigationTitle("Nouvelle publication")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        dismiss()
                    }
                    .font(ETTypography.callout)
                    .foregroundColor(ETColors.secondaryText)
                    .frame(minWidth: 44, minHeight: 44)
                    .contentShape(Rectangle())
                    .accessibilityLabel("Annuler la publication")
                }
            }
        }
    }
    
    private func mediaOptionButton(title: String, icon: String, type: PostMediaType) -> some View {
        Button(action: { selectedMediaType = type }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 13))
                Text(title)
                    .font(ETTypography.badge)
            }
            .foregroundColor(selectedMediaType == type ? ETColors.pureBlack : ETColors.pureWhite)
            .padding(.horizontal, 12)
            .frame(minHeight: 44)
            .background(selectedMediaType == type ? ETColors.primaryOrange : ETColors.darkSurface)
            .cornerRadius(ETRadius.button)
            .overlay(
                RoundedRectangle(cornerRadius: ETRadius.button)
                    .stroke(selectedMediaType == type ? Color.clear : ETColors.borderGray.opacity(0.15), lineWidth: 1)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title), \(selectedMediaType == type ? "sélectionné" : "")")
    }
    
    private func submitPost() {
        isSubmitting = true
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            MockDataService.shared.addPost(
                content: postContent,
                mediaType: selectedMediaType
            )
            isSubmitting = false
            isSuccess = true
            try? await Task.sleep(nanoseconds: 400_000_000)
            dismiss()
        }
    }
}
