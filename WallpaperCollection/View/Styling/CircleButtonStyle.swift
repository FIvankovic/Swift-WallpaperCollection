//
//  CircleButtonStyle.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import Foundation
import SwiftUI

struct CircleButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .font(.body.bold())
            .background(Color.white)
            .cornerRadius(20)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
