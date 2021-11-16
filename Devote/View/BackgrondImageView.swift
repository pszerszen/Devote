//
//  BackgrondImageView.swift
//  Devote
//
//  Created by Piotr Szerszeń on 16/11/2021.
//

import SwiftUI

struct BackgrondImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgrondImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgrondImageView()
    }
}
