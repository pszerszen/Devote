//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Piotr Szerszeń on 17/11/2021.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()

                    SoundPlayer.shared.playSound(configuration.isOn ? .rise : .tap)
                    feedback.notificationOccurred(.success)
                }
            configuration.label
        }
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Toggle("Placeholder label", isOn: .constant(true))
                .padding()
                .previewLayout(.sizeThatFits)
            .toggleStyle(CheckboxStyle())
            Toggle("Placeholder label", isOn: .constant(false))
                .padding()
                .previewLayout(.sizeThatFits)
                .toggleStyle(CheckboxStyle())
        }
    }
}
