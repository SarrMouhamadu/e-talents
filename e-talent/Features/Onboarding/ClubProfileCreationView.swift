import SwiftUI
import PhotosUI

public struct ClubProfileCreationView: View {
    @State private var clubName: String = ""
    @State private var city: String = "Dakar"
    @State private var selectedDivision: String = "National 1 Masculin"
    @State private var representativeName: String = ""
    @State private var representativeRole: String = "Coach Principal"
    @State private var clubDescription: String = ""
    
    // Photo selection state for Club Logo
    @State private var selectedLogoItem: PhotosPickerItem?
    @State private var logoImage: UIImage?
    @State private var logoData: Data?
    
    public var onComplete: () -> Void
    
    private let availableDivisions = [
        "National 1 Masculin",
        "National 1 Féminin",
        "National 2",
        "Centre de formation / Académie",
        "Catégorie Jeunes (U18 / U20)"
    ]
    
    private let availableRoles = [
        "Coach Principal",
        "Directeur Sportif",
        "Président / Dirigeant",
        "Recruteur",
        "Secrétaire Général"
    ]
    
    public init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: ETSpacing.standard) {
                    // En-tête
                    VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                        Text("Création de la fiche Club")
                            .font(ETTypography.largeTitle)
                            .foregroundColor(ETColors.pureWhite)
                        
                        Text("Renseignez les détails de votre club pour présenter votre équipe, publier vos détections et découvrir de nouveaux talents.")
                            .font(ETTypography.body)
                            .foregroundColor(ETColors.secondaryText)
                    }
                    .padding(.top, ETSpacing.standard)
                    
                    // Logo du club interactif avec PhotosPicker
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $selectedLogoItem, matching: .images) {
                            VStack(spacing: ETSpacing.xSmall) {
                                ZStack {
                                    if let logoImage {
                                        Image(uiImage: logoImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(ETColors.primaryOrange, lineWidth: 2)
                                            )
                                    } else {
                                        Circle()
                                            .fill(ETColors.darkSurface)
                                            .frame(width: 90, height: 90)
                                            .overlay(
                                                Circle().stroke(ETColors.primaryOrange, lineWidth: 1.5)
                                            )
                                        
                                        Image(systemName: "shield.checkered")
                                            .font(.system(size: 32))
                                            .foregroundColor(ETColors.primaryOrange)
                                    }
                                }
                                
                                Text(logoImage != nil ? "Modifier le logo" : "Ajouter le blason du club")
                                    .font(ETTypography.caption)
                                    .foregroundColor(ETColors.primaryOrange)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Ajouter le logo du club")
                        Spacer()
                    }
                    .onChange(of: selectedLogoItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                await MainActor.run {
                                    self.logoData = data
                                    self.logoImage = image
                                }
                            }
                        }
                    }
                    
                    // Formulaire Club
                    VStack(spacing: ETSpacing.standard) {
                        ETTextField(
                            title: "Nom officiel du club",
                            placeholder: "Ex: AS Douanes, DUC Basketball",
                            icon: "shield.fill",
                            text: $clubName
                        )
                        
                        ETTextField(
                            title: "Ville d'attache",
                            placeholder: "Ex: Dakar, Thiès, Saint-Louis",
                            icon: "mappin.circle.fill",
                            text: $city
                        )
                        
                        // Division / Catégorie
                        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                            Text("Division / Catégorie")
                                .font(ETTypography.callout)
                                .foregroundColor(ETColors.secondaryText)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: ETSpacing.xSmall) {
                                    ForEach(availableDivisions, id: \.self) { div in
                                        ETFilterChip(
                                            div,
                                            isSelected: selectedDivision == div,
                                            action: { selectedDivision = div }
                                        )
                                    }
                                }
                            }
                        }
                        
                        // Section Représentant
                        VStack(alignment: .leading, spacing: ETSpacing.small) {
                            Text("REPRÉSENTANT OFFICIEL")
                                .font(ETTypography.caption)
                                .fontWeight(.bold)
                                .foregroundColor(ETColors.secondaryText)
                            
                            ETTextField(
                                title: "Nom du représentant",
                                placeholder: "Ex: Coach Cheikh Sarr, M. Diallo",
                                icon: "person.crop.circle.badge.checkmark",
                                text: $representativeName
                            )
                            
                            // Rôle du représentant
                            VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                                Text("Fonction dans le club")
                                    .font(ETTypography.callout)
                                    .foregroundColor(ETColors.secondaryText)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: ETSpacing.xSmall) {
                                        ForEach(availableRoles, id: \.self) { role in
                                            ETFilterChip(
                                                role,
                                                isSelected: representativeRole == role,
                                                action: { representativeRole = role }
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, ETSpacing.xSmall)
                        
                        // Présentation / Bio du club
                        VStack(alignment: .leading, spacing: ETSpacing.xSmall) {
                            Text("Présentation du club")
                                .font(ETTypography.callout)
                                .foregroundColor(ETColors.secondaryText)
                            
                            ZStack(alignment: .topLeading) {
                                if clubDescription.isEmpty {
                                    Text("Présentez l'histoire du club, votre palmarès et vos créneaux de détection...")
                                        .font(ETTypography.body)
                                        .foregroundColor(ETColors.secondaryText)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                                
                                TextEditor(text: $clubDescription)
                                    .font(ETTypography.body)
                                    .foregroundColor(ETColors.pureWhite)
                                    .scrollContentBackground(.hidden)
                                    .frame(minHeight: 100)
                            }
                            .padding(ETSpacing.small)
                            .background(ETColors.darkSurface)
                            .cornerRadius(ETRadius.card)
                        }
                        
                        // Bouton finaliser
                        ETButton(
                            "Finaliser ma fiche Club",
                            icon: "checkmark",
                            style: .primary,
                            size: .large
                        ) {
                            saveClub()
                        }
                        .disabled(clubName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.top, ETSpacing.medium)
                        .padding(.bottom, ETSpacing.xLarge)
                    }
                }
                .padding(.horizontal, ETSpacing.standard)
            }
        }
    }
    
    private func saveClub() {
        let trimmedName = clubName.trimmingCharacters(in: .whitespacesAndNewlines)
        let newClub = Club(
            id: UUID().uuidString,
            name: trimmedName.isEmpty ? "Club E-Talent" : trimmedName,
            city: city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Dakar" : city,
            division: selectedDivision,
            isVerified: true,
            description: clubDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                ? "Club affilié à la Fédération Sénégalaise de Basketball (FSBB), engagé dans la formation et la performance des talents."
                : clubDescription,
            playersCount: 0,
            followersCount: 0,
            representativeName: representativeName.isEmpty ? nil : representativeName,
            representativeRole: representativeRole,
            logoData: logoData
        )
        
        MockDataService.shared.clubs.insert(newClub, at: 0)
        MockDataService.shared.currentClub = newClub
        UserDefaults.standard.set("club", forKey: "userAccountType")
        onComplete()
    }
}
