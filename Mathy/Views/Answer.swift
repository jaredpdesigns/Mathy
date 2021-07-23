//
//  Question.swift
//  Mathy
//
//  Created by Jared Pendergraft on 7/22/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct Answer: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settings: GlobalSettings
    @State private var orientation = UIDevice.current.orientation
    
    var buttonAdvance: some View {
        Button(action: { settings.answerCorrect ? settings.getNumbers():settings.reset() }) {
            HStack {
                if settings.answerCorrect {
                    Text("Try Another")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                        .imageScale(.medium)
                        .opacity(0.5)
                        .font(Font.body.weight(.bold))
                } else {
                    Image(systemName: "arrow.backward")
                        .imageScale(.medium)
                        .opacity(0.5)
                        .font(Font.body.weight(.bold))
                    Text("Try Again")
                        .fontWeight(.semibold)
                }
                
            }
            .frame(height: 48)
            .frame(maxWidth: 240)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
        }.buttonStyle(.plain)
    }
    
    var body: some View {
        ZStack {
            if orientation.isLandscape {
                HStack(spacing: 0) {
                    AnswerTop(portrait: false)
                    AnswerBottom(portrait: false)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThickMaterial)
                VStack {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .frame(height: verticalSizeClass == .compact ? 48:80)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            } else {
                VStack(spacing: 0) {
                    AnswerTop()
                    AnswerBottom()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThickMaterial)
            }
            VStack {
                Spacer()
                buttonAdvance
            }
            .padding()
            .padding(.bottom, 18)
        }
        .ignoresSafeArea()
        .background(Color.accentColor)
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

@available(iOS 15.0, *)
struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer().environmentObject(GlobalSettings())
    }
}
