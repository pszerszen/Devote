//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 16/11/2021.
//

import SwiftUI

struct NewTaskItemView: View {

    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @State private var task = ""
    @Binding var isShowing: Bool

    private var buttonDiabled: Bool {
        task.isEmpty
    }

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16.0) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(uiColor: .tertiarySystemBackground) :
                            Color(uiColor: .secondarySystemBackground)
                    )
                    .cornerRadius(12)
                Button {
                    addItem()
                    SoundPlayer.shared.playSound(.ding)
                    feedback.notificationOccurred(.success)
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(buttonDiabled)
                .onTapGesture {
                    if buttonDiabled {
                        SoundPlayer.shared.playSound(.tap)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(buttonDiabled ? .blue : .pink)
                .cornerRadius(12.0)
            }
            .padding(.horizontal)
            .padding(.vertical, 20.0)
            .background(isDarkMode ? Color(uiColor: .secondarySystemBackground) : Color.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }
        .padding()
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
