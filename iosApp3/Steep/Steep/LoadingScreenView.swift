//
//  LoadingScreenView.swift
//  Steep
//
//  Created by Ben on 8/28/25.
//

import SwiftUI

struct LoadingScreenView: View {
    @State private var imageScale: CGFloat = 0.5
    @State private var backgroundOpacity: Double = 1.0
    @State private var isAnimating = false
    
    // Match the tea timer colors
    private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
    private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
    
    var body: some View {
        ZStack {
            paper.ignoresSafeArea()
            
            VStack {
                Spacer()
                // Sample tea image that animates from 50% to 100%
                Image("hands")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .scaleEffect(imageScale)
                    .animation(.easeInOut(duration: 0.5), value: imageScale)
                Spacer()
            }
        }
        .opacity(backgroundOpacity)
        .animation(.easeInOut(duration: 0.6), value: backgroundOpacity)
        .onAppear {
            // Start the scale animation
            withAnimation {
                imageScale = 1.0
                isAnimating = true
            }
            
            // After scale animation completes (0.5s) + hold time (0.3s), fade out (0.6s)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    backgroundOpacity = 0.0
                }
            }
        }
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenView()
            .previewDevice("iPhone 15 Pro")
    }
}
