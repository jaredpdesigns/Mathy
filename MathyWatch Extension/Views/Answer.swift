//
//  QuestionLast.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI
import ConfettiSwiftUI

struct Answer: View {
    @EnvironmentObject var settings: GlobalSettings
    @State var confettiCount: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                ZStack {
                    Image(settings.answerCorrect ? "Face Happy":"Face Sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56, height: 56)
                        .foregroundColor(.white)
                        .scaleEffect(settings.isAnimating ? 1.125:1, anchor: .center)
                    if settings.answerCorrect {
                        ConfettiCannon(counter: $confettiCount, colors: [.accentColor, Color(UIColor(hexString: "#FFC72C")!), Color(UIColor(hexString: "#EF3340")!)])
                    }
                }
                Text(settings.answerCorrect ? "Great job!":"Oops…")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(settings.isAnimating ? 1.25:1, anchor: .center)
            Spacer()
            VStack {
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
                }
                .buttonStyle(.plain)
            }.padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .onAppear {
            if settings.answerCorrect {
                confettiCount += 1
            } else {
                settings.animateStuff()
            }
        }
    }
}

struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer().environmentObject(GlobalSettings())
    }
}
