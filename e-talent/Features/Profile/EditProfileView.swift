import SwiftUI
import PhotosUI

public struct EditProfileView: View {
    @Binding var player: Player
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var position: BasketballPosition
    @State private var height: String
    @State private var age: String
    @State private var city: String
    @State private var club: String
    @State private var bio: String
    @State private var isAvailable: Bool
    
    // Photo selection state
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    
    public init(player: Binding<Player>) {
        self._player = player
        self._name = State(initialValue: player.wrappedValue.name)
        self._position = State(initialValue: player.wrappedValue.position)
        self._height = State(initialValue: "\(player.wrappedValue.heightCm)")
        self._age = State(initialValue: "\(player.wrappedValue.age)")
        self._city = State(initialValue: player.wrappedValue.city)
        self._club = State(initialValue: player.wrappedValue.clubName ?? "")
        self._bio = State(initialValue: player.wrappedValue.bio)
        self._isAvailable = State(initialValue: player.wrappedValue.isAvailable)
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: ETSpacing.standard) {
                        // Avatar avec bouton changer photo
                        HStack {
                            Spacer()
                            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                                VStack(spacing: ETSpacing.xSmall) {
                                    ZStack {
                                        if let avatarImage {
                                            Image(uiImage: avatarImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle().stroke(ETColors.primaryOrange, lineWidth: 2)
                                                )
                                        } else {
                                            ETAvatar(name: name.isEmpty ? player.name : name, size: .large, isVerified: player.isVerified)
                                        }
                                    }
                                    
                                    Text("Changer la photo")
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.primaryOrange)
                                }
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Changer la photo de profil")
                            Spacer()
                        }
                        .padding(.top, ETSpacing.standard)
                        .onChange(of: selectedPhotoItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let image = UIImage(data: data) {
                                    await MainActor.run {
                                        self.avatarImage = image
                                    }
                                }
                            }
                        }
                        
                        // Formulaire
                        VStack(spacing: ETSpacing.standard) {
                            ETTextField(
                                title: "Nom complet",
                                placeholder: "Votre nom",
                                icon: "person.fill",
                                text: $name
                            )
                            
                            // Poste
                            VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                                Text("Poste de prédilection")
                                    .font(ETTypography.callout)
                                    .foregroundColor(ETColors.secondaryText)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: ETSpacing.xSmall) {
                                        ForEach(BasketballPosition.allCases) { pos in
                                            ETFilterChip(
                                                "\(pos.shortCode) - \(pos.rawValue)",
                                                isSelected: position == pos,
                                                action: { position = pos }
                                            )
                                        }
                                    }
                                }
                            }
                            
                            // Taille et Âge
                            HStack(spacing: ETSpacing.standard) {
                                ETTextField(
                                    title: "Taille (cm)",
                                    placeholder: "192",
                                    icon: "ruler",
                                    text: $height,
                                    keyboardType: .numberPad
                                )
                                
                                ETTextField(
                                    title: "Âge",
                                    placeholder: "19",
                                    icon: "calendar",
                                    text: $age,
                                    keyboardType: .numberPad
                                )
                            }
                            
                            ETTextField(
                                title: "Ville",
                                placeholder: "Ex: Dakar, Thiès...",
                                icon: "mappin.and.ellipse",
                                text: $city
                            )
                            
                            ETTextField(
                                title: "Club",
                                placeholder: "Laisser vide si sans club",
                                icon: "shield.fill",
                                text: $club
                            )
                            
                            ETTextField(
                                title: "Bio sportive",
                                placeholder: "Parlez de vos qualités, points forts...",
                                icon: "text.quote",
                                text: $bio
                            )
                            
                            // Disponibilité
                            Toggle(isOn: $isAvailable) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Disponible pour recrutement")
                                        .font(ETTypography.subheadlineBold)
                                        .foregroundColor(ETColors.pureWhite)
                                    Text("Visible par les coachs et clubs")
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.secondaryText)
                                }
                            }
                            .tint(ETColors.primaryOrange)
                            .padding(ETSpacing.standard)
                            .background(ETColors.darkSurface)
                            .cornerRadius(ETRadius.button)
                        }
                        
                        // Bouton Sauvegarder
                        ETButton("Enregistrer les modifications", icon: "checkmark", style: .primary, size: .large) {
                            saveChanges()
                        }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                        .padding(.top, ETSpacing.small)
                        .padding(.bottom, ETSpacing.large)
                    }
                    .padding(.horizontal, ETSpacing.standard)
                }
            }
            .navigationTitle("Modifier mon profil")
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
                }
            }
        }
    }
    
    private func saveChanges() {
        var updated = player
        updated.name = name.trimmingCharacters(in: .whitespaces)
        updated.position = position
        if let h = Int(height.trimmingCharacters(in: .whitespaces)) {
            updated.heightCm = h
        }
        if let a = Int(age.trimmingCharacters(in: .whitespaces)) {
            updated.age = a
        }
        updated.city = city.trimmingCharacters(in: .whitespaces)
        let trimmedClub = club.trimmingCharacters(in: .whitespaces)
        updated.clubName = trimmedClub.isEmpty ? nil : trimmedClub
        updated.bio = bio.trimmingCharacters(in: .whitespaces)
        updated.isAvailable = isAvailable
        
        player = updated
        MockDataService.shared.updatePlayer(updated)
        dismiss()
    }
}
