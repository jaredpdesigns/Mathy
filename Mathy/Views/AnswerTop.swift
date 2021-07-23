//
//  AnswerTop.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI
import ConfettiSwiftUI

struct AnswerTop: View {
    @EnvironmentObject var settings: GlobalSettings
    @State var confettiCount: Int = 0
    @State var portrait: Bool = true
    
    var body: some View {
        VStack {
            if portrait {
                Spacer()
            }
            ZStack {
                VStack(spacing: 16) {
                    Image(settings.answerCorrect ? "Face Happy":"Face Sad")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 128:64, height: UIDevice.current.userInterfaceIdiom == .pad ? 128:64)
                        .scaleEffect(settings.isAnimating ? 1.25:1, anchor: .center)
                    Text(settings.answerCorrect ? "Great job!":"Oops…")
                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 64:48))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
                if settings.answerCorrect {
                    ConfettiCannon(counter: $confettiCount, colors: [.accentColor, Color(UIColor(hexString: "#FFC72C")!), Color(UIColor(hexString: "#EF3340")!)])
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if settings.answerCorrect {
                confettiCount += 1
            } else {
                settings.animateStuff()
            }
        }
    }
}

struct AnswerTop_Previews: PreviewProvider {
    static var previews: some View {
        AnswerTop().environmentObject(GlobalSettings())
    }
}
