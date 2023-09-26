//
//  LottieView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let lottieFile: String
 
    let animationView = LottieAnimationView()
    @Binding var favouriteInProgress: Bool
    @Binding var downloadInProgress: Bool
    @Binding var unfavoriteInProgress: Bool
    
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play{ complete in
            if complete {
                favouriteInProgress = false
                downloadInProgress = false
                unfavoriteInProgress = false
            }
        }
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

