//
//  AnswerBottom.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI

struct AnswerBottom: View {
    @EnvironmentObject var settings: GlobalSettings
    @State var portrait: Bool = true
    var body: some View {
        VStack {
            Text(settings.answer)
                .padding()
                .multilineTextAlignment(.center)
                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
                .scaleEffect(settings.isAnimating ? 1.25:1, anchor: .center)
            if portrait {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if !settings.answerCorrect {
                settings.animateStuff()
            }
        }
    }
}

struct AnswerBottom_Previews: PreviewProvider {
    static var previews: some View {
        AnswerBottom().environmentObject(GlobalSettings())
    }
}
