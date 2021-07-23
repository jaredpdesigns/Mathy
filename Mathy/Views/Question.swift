//
//  Question.swift
//  Mathy
//
//  Created by Jared Pendergraft on 7/22/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct Question: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settings: GlobalSettings
    @State private var orientation = UIDevice.current.orientation
    
    var buttonCheckAnswer: some View {
        Button(action: { settings.checkAnswer() }) {
            HStack {
                Image(systemName: "checkmark")
                    .imageScale(.medium)
                    .opacity(0.5)
                    .font(Font.body.weight(.bold))
                Text("Check Answer")
                    .fontWeight(.semibold)
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
                        QuestionTop()
                        QuestionBottom()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.accentColor)
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
                    QuestionTop()
                    QuestionBottom()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.accentColor)
            }
            if settings.answer != "" {
                VStack {
                    Spacer()
                    buttonCheckAnswer
                }
                .padding()
                .padding(.bottom, 18)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            settings.getNumbers()
        }
        .onChange(of: settings.selectedOperator) { _ in
            settings.getSolution()
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

@available(iOS 15.0, *)
struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question().environmentObject(GlobalSettings())
    }
}
