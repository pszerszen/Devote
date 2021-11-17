//
//  BlankView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 16/11/2021.
//

import SwiftUI

struct BlankView: View {

    var backgroundColor: Color
    var backgroundOpacity: Double

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
            .background(BackgrondImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
