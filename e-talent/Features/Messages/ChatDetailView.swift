import SwiftUI

public struct ChatDetailView: View {
    public let conversation: Conversation
    @State private var messages: [ChatMessage] = [
        ChatMessage(
            senderId: "coach",
            text: "Bonjour ! J'ai vu tes vidéos de highlights contre l'AS Douanes.",
            timestamp: "14:28",
            isFromCurrentUser: false,
            status: .read
        ),
        ChatMessage(
            senderId: "coach",
            text: "Tes tirs en sortie d'écran et ton intensité défensive nous intéressent beaucoup.",
            timestamp: "14:29",
            isFromCurrentUser: false,
            status: .read
        ),
        ChatMessage(
            senderId: "me",
            text: "Bonjour Coach, merci beaucoup pour le retour ! Je m'entraîne dur tous les jours pour ça.",
            timestamp: "14:31",
            isFromCurrentUser: true,
            status: .read
        ),
        ChatMessage(
            senderId: "coach",
            text: "Es-tu disponible mardi matin pour échanger plus en détail au club ?",
            timestamp: "14:32",
            isFromCurrentUser: false,
            status: .read
        )
    ]
    @State private var messageText: String = ""
    
    public init(conversation: Conversation) {
        self.conversation = conversation
    }
    
    public var body: some View {
        ZStack {
            ETColors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Messages Scroll
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: ETSpacing.small) {
                            ForEach(messages) { msg in
                                messageBubble(msg)
                                    .id(msg.id)
                            }
                        }
                        .padding(ETSpacing.standard)
                    }
                    .onChange(of: messages.count) {
                        if let lastId = messages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastId, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input Bar
                HStack(spacing: ETSpacing.small) {
                    TextField(
                        "",
                        text: $messageText,
                        prompt: Text("Votre message...").foregroundColor(ETColors.secondaryText)
                    )
                    .font(ETTypography.body)
                    .foregroundColor(ETColors.pureWhite)
                    .padding(.horizontal, ETSpacing.standard)
                    .frame(height: 44)
                    .background(ETColors.darkSurface)
                    .cornerRadius(ETRadius.pill)
                    
                    let isMessageEmpty = messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16))
                            .foregroundColor(isMessageEmpty ? ETColors.secondaryText : ETColors.pureBlack)
                            .frame(width: 44, height: 44)
                            .background(
                                isMessageEmpty ?
                                ETColors.darkSurface : ETColors.primaryOrange
                            )
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(ETColors.borderGray.opacity(isMessageEmpty ? 0.15 : 0), lineWidth: 1)
                            )
                    }
                    .disabled(isMessageEmpty)
                    .accessibilityLabel("Envoyer le message")
                }
                .padding(.horizontal, ETSpacing.standard)
                .padding(.vertical, ETSpacing.small)
                .background(ETColors.darkSurface.opacity(0.5))
            }
        }
        .navigationTitle(conversation.participantName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func messageBubble(_ msg: ChatMessage) -> some View {
        HStack {
            if msg.isFromCurrentUser { Spacer(minLength: 40) }
            
            VStack(alignment: msg.isFromCurrentUser ? .trailing : .leading, spacing: 3) {
                Text(msg.text)
                    .font(ETTypography.body)
                    .foregroundColor(msg.isFromCurrentUser ? ETColors.pureBlack : ETColors.pureWhite)
                
                HStack(spacing: 4) {
                    Text(msg.timestamp)
                        .font(ETTypography.caption)
                        .foregroundColor(msg.isFromCurrentUser ? ETColors.pureBlack.opacity(0.75) : ETColors.secondaryText)
                    
                    // Point 5: Statut de lecture du message
                    if msg.isFromCurrentUser {
                        statusView(for: msg.status)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(msg.isFromCurrentUser ? ETColors.primaryOrange : ETColors.darkSurface)
            .cornerRadius(16)
            
            if !msg.isFromCurrentUser { Spacer(minLength: 40) }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(msg.isFromCurrentUser ? "Moi" : conversation.participantName), \(msg.text), \(msg.timestamp), \(msg.isFromCurrentUser ? "statut " + msg.status.rawValue : "")")
    }
    
    @ViewBuilder
    private func statusView(for status: MessageStatus) -> some View {
        HStack(spacing: 2) {
            switch status {
            case .sending:
                Image(systemName: "clock")
                    .font(.system(size: 9))
                    .foregroundColor(ETColors.pureBlack.opacity(0.6))
            case .sent:
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(ETColors.pureBlack.opacity(0.7))
            case .delivered:
                HStack(spacing: -3) {
                    Image(systemName: "checkmark")
                    Image(systemName: "checkmark")
                }
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(ETColors.pureBlack.opacity(0.7))
            case .read:
                HStack(spacing: 2) {
                    HStack(spacing: -3) {
                        Image(systemName: "checkmark")
                        Image(systemName: "checkmark")
                    }
                    .font(.system(size: 10, weight: .bold))
                    Text("Lu")
                        .font(.system(size: 9, weight: .bold))
                }
                .foregroundColor(ETColors.pureBlack)
            }
        }
    }
    
    private func sendMessage() {
        let trimmed = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let newMsg = ChatMessage(
            senderId: "me",
            text: trimmed,
            timestamp: "À l'instant",
            isFromCurrentUser: true,
            status: .sent
        )
        messages.append(newMsg)
        messageText = ""
        
        let msgId = newMsg.id
        // Simulation dynamique du cycle de vie : Envoyé -> Distribué -> Lu
        Task {
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            if let idx = messages.firstIndex(where: { $0.id == msgId }) {
                messages[idx].status = .delivered
            }
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            if let idx = messages.firstIndex(where: { $0.id == msgId }) {
                messages[idx].status = .read
            }
        }
    }
}
