import SwiftUI

struct LettersView: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    @State private var tab: Int = 0   // 0 pending, 1 answered

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                tabButton("Pending (\(store.pendingLetters.count))", idx: 0)
                tabButton("Answered (\(store.answeredLetters.count))", idx: 1)
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            .background(LighthouseKeeperPalette.surfaceSunken)

            ScrollView {
                LazyVStack(spacing: 10) {
                    if tab == 0 {
                        if store.pendingLetters.isEmpty {
                            emptyState("No letters waiting. The next packet arrives soon.")
                        }
                        ForEach(store.pendingLetters, id: \.id) { letter in
                            NavigationLink(destination: LetterDetail(letter: letter, alreadyAnswered: nil)) {
                                letterRow(letter, isPending: true)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        if store.answeredLetters.isEmpty {
                            emptyState("You haven't replied to any letters yet.")
                        }
                        ForEach(store.answeredLetters, id: \.0.id) { pair in
                            NavigationLink(destination: LetterDetail(letter: pair.0, alreadyAnswered: pair.1)) {
                                letterRow(pair.0, isPending: false, answered: pair.1)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(12)
            }
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle("Telegrams", displayMode: .inline)
    }

    private func tabButton(_ title: String, idx: Int) -> some View {
        Button { tab = idx } label: {
            Text(title)
                .font(.system(size: 13, weight: .bold))
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(tab == idx ? LighthouseKeeperPalette.amber : Color.clear)
                .foregroundColor(tab == idx ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.inkMid)
                .cornerRadius(4)
        }
        .padding(.horizontal, 4)
    }

    private func emptyState(_ text: String) -> some View {
        VStack(spacing: 8) {
            LetterIcon(size: 40, color: LighthouseKeeperPalette.inkSoft)
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(LighthouseKeeperPalette.inkMid)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
    }

    private func letterRow(_ letter: Letter, isPending: Bool, answered: LetterRecord? = nil) -> some View {
        HStack(spacing: 10) {
            VStack {
                LetterIcon(size: 24, color: isPending ? LighthouseKeeperPalette.amber : LighthouseKeeperPalette.teal)
                Text("N\(letter.nightAvailable)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(letter.title)
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(LighthouseKeeperPalette.inkDark)
                Text(letter.correspondent.displayName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(LighthouseKeeperPalette.rust)
                Text(letter.body)
                    .font(.system(size: 12))
                    .foregroundColor(LighthouseKeeperPalette.inkMid)
                    .lineLimit(2)
            }
            Spacer()
            if isPending {
                Text("READ")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .padding(.horizontal, 6).padding(.vertical, 4)
                    .background(LighthouseKeeperPalette.amber)
                    .foregroundColor(LighthouseKeeperPalette.teal)
                    .cornerRadius(3)
            } else if let a = answered, let _ = a.chosen {
                CheckGlyph(size: 18, color: LighthouseKeeperPalette.teal)
            }
            ChevronGlyph(direction: .right, size: 14, color: LighthouseKeeperPalette.inkSoft)
        }
        .padding(10)
        .background(LighthouseKeeperPalette.surface)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(LighthouseKeeperPalette.divider, lineWidth: 1))
    }
}

// MARK: - Letter Detail

struct LetterDetail: View {
    @EnvironmentObject var store: LighthouseKeeperStore
    let letter: Letter
    let alreadyAnswered: LetterRecord?
    @Environment(\.presentationMode) var presentation
    @State private var picked: String? = nil
    @State private var feedback: String? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header
                bodyCard
                if let ans = alreadyAnswered, let c = ans.chosen,
                   let choice = letter.choices.first(where: { $0.id == c }) {
                    answeredCard(choice)
                } else {
                    choicesList
                }
                if let f = feedback {
                    Text(f)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(LighthouseKeeperPalette.teal)
                        .padding(10)
                        .background(LighthouseKeeperPalette.surfaceSunken)
                        .cornerRadius(6)
                }
            }
            .padding(14)
        }
        .background(LighthouseKeeperPalette.surface.ignoresSafeArea())
        .navigationBarTitle(letter.title, displayMode: .inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(letter.correspondent.displayName.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(2)
                .foregroundColor(LighthouseKeeperPalette.amber)
            Text(letter.title)
                .font(.system(size: 20, weight: .heavy, design: .serif))
                .foregroundColor(LighthouseKeeperPalette.sand)
            HStack {
                Text("Arc: \(letter.correspondent.arc.label)")
                    .font(.system(size: 11))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.8))
                Spacer()
                Text("Posted: Night \(letter.nightAvailable)")
                    .font(.system(size: 11))
                    .foregroundColor(LighthouseKeeperPalette.sand.opacity(0.8))
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(colors: [LighthouseKeeperPalette.teal, LighthouseKeeperPalette.slate], startPoint: .leading, endPoint: .trailing))
        .cornerRadius(8)
    }

    private var bodyCard: some View {
        Text(letter.body)
            .font(.system(size: 14, design: .serif))
            .foregroundColor(LighthouseKeeperPalette.inkDark)
            .lineSpacing(4)
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LighthouseKeeperPalette.surfaceSunken)
            .cornerRadius(8)
    }

    private var choicesList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("YOUR REPLY")
                .font(.system(size: 11, weight: .bold))
                .tracking(2)
                .foregroundColor(LighthouseKeeperPalette.inkMid)
            ForEach(letter.choices, id: \.id) { choice in
                Button {
                    picked = choice.id
                } label: {
                    HStack(alignment: .top, spacing: 10) {
                        Circle()
                            .stroke(LighthouseKeeperPalette.teal, lineWidth: 1.5)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Circle().fill(picked == choice.id ? LighthouseKeeperPalette.teal : Color.clear)
                                    .padding(3)
                            )
                        Text(choice.text)
                            .font(.system(size: 13))
                            .foregroundColor(LighthouseKeeperPalette.inkDark)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(10)
                    .background(LighthouseKeeperPalette.surface)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(picked == choice.id ? LighthouseKeeperPalette.teal : LighthouseKeeperPalette.divider, lineWidth: 1))
                }
                .buttonStyle(PlainButtonStyle())
            }
            Button {
                guard let p = picked else {
                    feedback = "Pick a reply first."
                    return
                }
                // Guard against duplicate answers (e.g., back-stack into a now-answered letter).
                if store.isLetterAnswered(letter.id) {
                    feedback = "You've already replied to this letter."
                    return
                }
                store.answerLetter(letter, choiceId: p)
                feedback = "Sent. The next mail packet will reach the cape soon."
            } label: {
                Text(store.isLetterAnswered(letter.id) ? "Already sent" : "Seal & Send")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(store.isLetterAnswered(letter.id) ? LighthouseKeeperPalette.slate : LighthouseKeeperPalette.amber)
                    .foregroundColor(store.isLetterAnswered(letter.id) ? LighthouseKeeperPalette.sand : LighthouseKeeperPalette.teal)
                    .cornerRadius(6)
            }
            .disabled(store.isLetterAnswered(letter.id))
        }
    }

    private func answeredCard(_ choice: LetterChoice) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("YOUR REPLY (sent)")
                .font(.system(size: 11, weight: .bold))
                .tracking(2)
                .foregroundColor(LighthouseKeeperPalette.inkMid)
            Text(choice.text)
                .font(.system(size: 13))
                .foregroundColor(LighthouseKeeperPalette.inkDark)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LighthouseKeeperPalette.surfaceSunken)
                .cornerRadius(6)
        }
    }
}
