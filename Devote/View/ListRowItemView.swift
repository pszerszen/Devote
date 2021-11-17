//
//  ListRowItemView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 17/11/2021.
//

import SwiftUI

struct ListRowItemView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var item: Item

    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary)
                .padding(.vertical, 12.0)
                .animation(.default, value: item.completion)
        }
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

