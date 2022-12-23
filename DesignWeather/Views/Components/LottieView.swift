//
//  LottieView.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/12/2022.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let lottieFile: String
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        let animationView = LottieAnimationView(name: lottieFile)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
