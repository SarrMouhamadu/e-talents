import SwiftUI

public struct MessagesView: View {
    @State private var conversations = MockData.sampleConversations
    @State private var searchText: String = ""
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                ETColors.background.ignoresSafeArea()
                
                VStack(spacing: ETSpacing.small) {
                    ETSearchBar(text: $searchText, placeholder: "Rechercher une discussion...")
                        .padding(.horizontal, ETSpacing.standard)
                        .padding(.top, ETSpacing.xSmall)
                    
                    if filteredConversations.isEmpty {
                        ETEmptyState(
                            icon: "bubble.left.and.bubble.right",
                            title: "Aucun message",
                            description: "Contactez un joueur ou un club depuis son profil pour démarrer un échange."
                        )
                        .padding(.top, ETSpacing.large)
                    } else {
                        List {
                            ForEach(filteredConversations) { conv in
                                NavigationLink(destination: ChatDetailView(conversation: conv)) {
                                    HStack(spacing: ETSpacing.standard) {
                                        ETAvatar(name: conv.participantName, size: .medium, isVerified: conv.isVerified)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack {
                                                Text(conv.participantName)
                                                    .font(ETTypography.subheadlineBold)
                                                    .foregroundColor(ETColors.pureWhite)
                                                    .lineLimit(1)
                                                
                                                Spacer()
                                                
                                                Text(conv.timeAgo)
                                                    .font(ETTypography.caption)
                                                    .foregroundColor(conv.unreadCount > 0 ? ETColors.primaryOrange : ETColors.secondaryText)
                                            }
                                            
                                            HStack {
                                                Text(conv.lastMessage)
                                                    .font(ETTypography.callout)
                                                    .foregroundColor(conv.unreadCount > 0 ? ETColors.pureWhite : ETColors.secondaryText)
                                                    .fontWeight(conv.unreadCount > 0 ? .medium : .regular)
                                                    .lineLimit(1)
                                                
                                                Spacer()
                                                
                                                if conv.unreadCount > 0 {
                                                    Text("\(conv.unreadCount)")
                                                        .font(.system(size: 11, weight: .bold))
                                                        .foregroundColor(ETColors.textOnOrange)
                                                        .frame(width: 20, height: 20)
                                                        .background(ETColors.primaryOrange)
                                                        .clipShape(Circle())
                                                }
                                            }
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparatorTint(ETColors.borderGray.opacity(0.12))
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var filteredConversations: [Conversation] {
        if searchText.isEmpty {
            return conversations
        }
        return conversations.filter {
            $0.participantName.localizedCaseInsensitiveContains(searchText) ||
            $0.lastMessage.localizedCaseInsensitiveContains(searchText)
        }
    }
}
