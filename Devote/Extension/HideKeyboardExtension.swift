//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Piotr Szerszeń on 15/11/2021.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
