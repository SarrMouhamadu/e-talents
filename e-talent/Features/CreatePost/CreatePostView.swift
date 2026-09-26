import SwiftUI
import PhotosUI

public struct CreatePostView: View {
    @State private var postContent: String = ""
    @State private var selectedMediaType: PostMediaType = .photo
    @State private var mediaCaption: String = "Workout Session • Marius Ndiaye"
    @State private var isSubmitting: Bool = false
    @State private var isSuccess: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    // Photo / Video picker states
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var selectedImage: UIImage?
    @State private var selectedVideoFilename: String?
    @State private var isLoadingMedia: Bool = false
    
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
                        
                        // Choix du format média
                        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                            Text("TYPE DE CONTENU")
                                .font(ETTypography.caption)
                                .fontWeight(.bold)
                                .foregroundColor(ETColors.secondaryText)
                            
                            HStack(spacing: ETSpacing.small) {
                                mediaOptionButton(
                                    title: "Photo",
                                    icon: "photo.fill",
                                    type: .photo
                                )
                                
                                mediaOptionButton(
                                    title: "Vidéo Highlight",
                                    icon: "play.circle.fill",
                                    type: .video
                                )
                                
                                mediaOptionButton(
                                    title: "Texte seul",
                                    icon: "text.alignleft",
                                    type: .none
                                )
                            }
                        }
                        
                        // Sélecteur & Aperçu du média
                        if selectedMediaType != .none {
                            VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                                HStack {
                                    Text(selectedMediaType == .video ? "VIDÉO HIGHLIGHT" : "PHOTO")
                                        .font(ETTypography.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(ETColors.secondaryText)
                                    
                                    Spacer()
                                    
                                    if selectedImage != nil || selectedVideoFilename != nil {
                                        Button("Supprimer") {
                                            selectedPickerItem = nil
                                            selectedImageData = nil
                                            selectedImage = nil
                                            selectedVideoFilename = nil
                                        }
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.error)
                                        .frame(minHeight: 44)
                                    }
                                }
                                
                                // Preview Container or Selector
                                if let selectedImage {
                                    // Live image preview
                                    let imgRatio: Double = selectedImage.size.height > 0 ? max(0.8, min(1.91, Double(selectedImage.size.width / selectedImage.size.height))) : 1.0
                                    
                                    ZStack(alignment: .bottomTrailing) {
                                        Color.clear
                                            .aspectRatio(imgRatio, contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                            .frame(maxHeight: 280)
                                            .overlay(
                                                GeometryReader { proxy in
                                                    Image(uiImage: selectedImage)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: proxy.size.width, height: proxy.size.height)
                                                        .clipped()
                                                }
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: ETRadius.media))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: ETRadius.media)
                                                    .stroke(ETColors.primaryOrange.opacity(0.4), lineWidth: 1.5)
                                            )
                                        
                                        PhotosPicker(
                                            selection: $selectedPickerItem,
                                            matching: .images
                                        ) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "arrow.triangle.2.circlepath")
                                                Text("Changer")
                                            }
                                            .font(ETTypography.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(ETColors.pureBlack)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(ETColors.primaryOrange)
                                            .cornerRadius(ETRadius.small)
                                            .padding(ETSpacing.small)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                } else if let videoName = selectedVideoFilename {
                                    // Video Selected Preview Card
                                    VStack(spacing: ETSpacing.small) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: ETRadius.media)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [Color(hex: "#1F1F24"), Color(hex: "#121215")],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                                .frame(maxHeight: 220)
                                                .overlay(
                                                    VStack(spacing: ETSpacing.xSmall) {
                                                        Image(systemName: "play.circle.fill")
                                                            .font(.system(size: 44))
                                                            .foregroundColor(ETColors.primaryOrange)
                                                        
                                                        Text(videoName)
                                                            .font(ETTypography.subheadlineBold)
                                                            .foregroundColor(ETColors.pureWhite)
                                                            .lineLimit(1)
                                                        
                                                        Text("Highlight prêt pour mise en ligne")
                                                            .font(ETTypography.caption)
                                                            .foregroundColor(ETColors.secondaryText)
                                                    }
                                                    .padding(.horizontal, ETSpacing.small)
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: ETRadius.media)
                                                        .stroke(ETColors.primaryOrange.opacity(0.4), lineWidth: 1.5)
                                                )
                                        }
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        
                                        PhotosPicker(
                                            selection: $selectedPickerItem,
                                            matching: .videos
                                        ) {
                                            HStack(spacing: 6) {
                                                Image(systemName: "arrow.triangle.2.circlepath")
                                                Text("Choisir une autre vidéo")
                                            }
                                            .font(ETTypography.callout)
                                            .foregroundColor(ETColors.primaryOrange)
                                            .frame(maxWidth: .infinity, minHeight: 44)
                                            .background(ETColors.darkSurface)
                                            .cornerRadius(ETRadius.button)
                                        }
                                    }
                                } else {
                                    // Empty picker trigger button
                                    PhotosPicker(
                                        selection: $selectedPickerItem,
                                        matching: selectedMediaType == .video ? .videos : .images
                                    ) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: ETRadius.media)
                                                .fill(ETColors.darkSurface)
                                                .aspectRatio(selectedMediaType == .video ? 16.0 / 9.0 : 4.0 / 3.0, contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                                .frame(maxHeight: 200)
                                                .overlay(
                                                    VStack(spacing: ETSpacing.small) {
                                                        if isLoadingMedia {
                                                            ProgressView()
                                                                .tint(ETColors.primaryOrange)
                                                                .scaleEffect(1.2)
                                                            Text("Chargement du média...")
                                                                .font(ETTypography.caption)
                                                                .foregroundColor(ETColors.secondaryText)
                                                        } else {
                                                            Image(systemName: selectedMediaType == .video ? "video.badge.plus" : "photo.badge.plus")
                                                                .font(.system(size: 34))
                                                                .foregroundColor(ETColors.primaryOrange)
                                                            
                                                            Text(selectedMediaType == .video ? "Sélectionner une vidéo highlight" : "Sélectionner une photo")
                                                                .font(ETTypography.subheadlineBold)
                                                                .foregroundColor(ETColors.pureWhite)
                                                            
                                                            Text("Appuyez pour ouvrir la galerie")
                                                                .font(ETTypography.caption)
                                                                .foregroundColor(ETColors.secondaryText)
                                                        }
                                                    }
                                                    .padding(.horizontal, ETSpacing.small)
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: ETRadius.media)
                                                        .strokeBorder(
                                                            style: StrokeStyle(lineWidth: 1.5, dash: [6, 4])
                                                        )
                                                        .foregroundColor(ETColors.primaryOrange.opacity(0.6))
                                                )
                                        }
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                    }
                                    .buttonStyle(.plain)
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
            .onChange(of: selectedPickerItem) { _, newItem in
                handleMediaSelection(newItem)
            }
        }
    }
    
    private func mediaOptionButton(title: String, icon: String, type: PostMediaType) -> some View {
        Button(action: {
            selectedMediaType = type
            selectedPickerItem = nil
            selectedImageData = nil
            selectedImage = nil
            selectedVideoFilename = nil
        }) {
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
    
    private func handleMediaSelection(_ item: PhotosPickerItem?) {
        guard let item else { return }
        isLoadingMedia = true
        
        Task {
            if selectedMediaType == .photo {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        self.selectedImageData = data
                        self.selectedImage = uiImage
                        self.isLoadingMedia = false
                    }
                } else {
                    await MainActor.run {
                        self.isLoadingMedia = false
                    }
                }
            } else if selectedMediaType == .video {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    let formattedSize = ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file)
                    await MainActor.run {
                        self.selectedVideoFilename = "Highlight_Dakar_2026.mp4 (\(formattedSize))"
                        self.isLoadingMedia = false
                    }
                } else {
                    await MainActor.run {
                        self.selectedVideoFilename = "Highlight_Dakar_2026.mp4"
                        self.isLoadingMedia = false
                    }
                }
            }
        }
    }
    
    private func submitPost() {
        isSubmitting = true
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            MockDataService.shared.addPost(
                content: postContent,
                mediaType: selectedMediaType,
                caption: selectedVideoFilename ?? (selectedMediaType == .video ? "Session Highlight 2026" : "Photo de performance"),
                imageData: selectedImageData
            )
            isSubmitting = false
            isSuccess = true
            try? await Task.sleep(nanoseconds: 400_000_000)
            dismiss()
        }
    }
}
