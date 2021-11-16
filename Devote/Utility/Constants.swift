//
//  Constants.swift
//  Devote
//
//  Created by Piotr Szerszeń on 15/11/2021.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient = LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
