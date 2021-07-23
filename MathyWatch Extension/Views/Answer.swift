//
//  QuestionLast.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct Answer: View {
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                Image(settings.answerCorrect ? "Face Happy":"Face Sad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56, height: 56)
                .foregroundColor(.white)
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
                    .background(.black)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }.padding()
        }
        .background(settings.answerCorrect ? Color(UIColor(hexString: "#00965E")!):Color(UIColor(hexString: "#EF3340")!))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        
    }
}

struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer().environmentObject(GlobalSettings())
    }
}
