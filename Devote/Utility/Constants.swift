//
//  Constants.swift
//  Devote
//
//  Created by Piotr Szerszeń on 15/11/2021.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
