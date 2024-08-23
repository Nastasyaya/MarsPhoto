//
//  PreloaderView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Lottie
import SwiftUI

struct PreloaderView: View {
    var body: some View {
            Color.backgroundOne
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(Color.accentOne)
                        .frame(width: 123, height: 123)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.black, lineWidth: 1)
                        )
                        .shadow(
                            color: .black.opacity(0.1),
                            radius: 10,
                            x: 0,
                            y: 20
                        )
                }
                                
                LottieView(
                    animation: .named("loadingItem")
                )
                .playing(loopMode: .loop)
                .offset(y: 40)
    }
}

#Preview {
    PreloaderView()
}
