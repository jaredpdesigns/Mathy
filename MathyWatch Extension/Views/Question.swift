//
//  QuestionFirst.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct Question: View {
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { settings.isShowingSheet.toggle() }) {
                    VStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(Font.caption.weight(.bold))
                    }
                    .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
                Button(action: { settings.getNumbers() }) {
                    VStack {
                        Image(systemName: "arrow.clockwise")
                            .font(Font.caption.weight(.bold))
                    }
                    .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
                Spacer()
            }
            HStack(spacing: 4) {
                Text("\(settings.numberOne)")
                    .font(.largeTitle)
                ZStack {
                    Image(systemName: "circle.fill")
                    Image(systemName: "\(settings.selectedOperator).circle.fill")
                        .foregroundColor(.black)
                }
                .font(.title2)
                .imageScale(.small)
                Text("\(settings.numberTwo)")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(settings.selectedTheme.colorBG)
            HStack {
                TextField("Equals…", text: $settings.answer)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                if settings.answer != "" {
                    VStack {
                        Button(action: { settings.checkAnswer() }) {
                            HStack {
                                Image(systemName: "checkmark")
                                    .font(Font.body.weight(.bold))
                            }
                            .frame(width: 40, height: 40)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }.padding()
        }
        .ignoresSafeArea()
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question().environmentObject(GlobalSettings())
    }
}
