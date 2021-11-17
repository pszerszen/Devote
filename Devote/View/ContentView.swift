//
//  ContentView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 13/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @AppStorage("isDarkMode") private var isDarkMode = false

    @State private var showNewTaskItem = false

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Main View
                VStack {
                    // MARK: - Header
                    HStack(spacing: 10.0) {
                        Text("Devote")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.leading, 4.0)
                        Spacer()

                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10.0)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule()
                                            .stroke(Color.white, lineWidth: 2))

                        // MARK: - Toggle Appearance
                        Button {
                            isDarkMode.toggle()
                            SoundPlayer.shared.playSound(.tap)
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                                .font(.title)
                        }
                    }
                    .padding()
                    .foregroundColor(.white)

                    Spacer(minLength: 80)

                    // MARK: - New task button
                    Button {
                        showNewTaskItem = true
                        SoundPlayer.shared.playSound(.ding)
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 15.0)
                    .background(LinearGradient(colors: [.pink, .blue],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                                    .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)

                    // MARK: - Tasks
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0.0)
                    .frame(maxWidth: 640)
                }
                .blur(while: showNewTaskItem)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: isDarkMode)

                // MARK: - New task
                if showNewTaskItem {
                    BlankView(backgroundColor: isDarkMode ? .black : .gray,
                              backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
            })
            .navigationTitle("Daily Task")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .background(BackgrondImageView()
                            .blur(while: showNewTaskItem))
            .background(backgroundGradient.ignoresSafeArea(.all))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

fileprivate extension View {

    func blur(while shouldBlur: Bool) -> some View {
        self.blur(radius: shouldBlur ? 8 : 0, opaque: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
