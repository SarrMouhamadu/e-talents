import SwiftUI

public struct NotificationsView: View {
    @State private var notifications = MockData.sampleNotifications
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            if notifications.isEmpty {
                ETEmptyState(
                    icon: "bell.slash",
                    title: "Aucune notification",
                    description: "Vos nouvelles interactions, likes et consultations de profil apparaîtront ici."
                )
            } else {
                List {
                    ForEach(notifications) { item in
                        HStack(alignment: .top, spacing: ETSpacing.standard) {
                            // Icône du type de notification
                            ZStack {
                                Circle()
                                    .fill(ETColors.darkSurface)
                                    .frame(width: 42, height: 42)
                                
                                Image(systemName: iconName(for: item.type))
                                    .font(.system(size: 18))
                                    .foregroundColor(item.type == .scout ? ETColors.senegalGreen : ETColors.primaryOrange)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(item.actorName)
                                        .font(ETTypography.subheadlineBold)
                                        .foregroundColor(ETColors.pureWhite)
                                    
                                    if let role = item.actorRole {
                                        ETBadge(role, style: .neutral)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.timeAgo)
                                        .font(ETTypography.caption)
                                        .foregroundColor(ETColors.secondaryText)
                                }
                                
                                Text(item.actionDescription)
                                    .font(ETTypography.body)
                                    .foregroundColor(item.isRead ? ETColors.secondaryText : ETColors.pureWhite)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(item.isRead ? Color.clear : ETColors.darkSurface.opacity(0.4))
                        .listRowSeparatorTint(ETColors.borderGray.opacity(0.12))
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(item.actorName), \(item.actionDescription), \(item.timeAgo)")
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Notifications")
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
    
    private func iconName(for type: NotificationType) -> String {
        switch type {
        case .scout: return "eye.fill"
        case .like: return "heart.fill"
        case .comment: return "bubble.left.fill"
        case .follow: return "person.badge.plus.fill"
        case .message: return "paperplane.fill"
        }
    }
}
