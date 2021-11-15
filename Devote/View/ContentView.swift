//
//  ContentView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 13/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var task = ""

    private var buttonDiabled: Bool {
        task.isEmpty
    }

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16.0) {
                    TextField("New Task", text: $task)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                    Button {
                        addItem()
                    } label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    }
                    .disabled(buttonDiabled)
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(buttonDiabled ? .gray : .pink)
                    .cornerRadius(12.0)
                }
                .padding()

                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.task ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }

                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Daily Task")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            Text("Select an item")
        }
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
