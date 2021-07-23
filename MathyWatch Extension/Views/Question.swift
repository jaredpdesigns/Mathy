//
//  QuestionFirst.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct Question: View {
    @EnvironmentObject var settings: GlobalSettings
    @Binding var isShowingSheet: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { isShowingSheet.toggle() }) {
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
            HStack(spacing: 0) {
                Text("\(settings.numberOne)")
                    .font(.largeTitle)
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(settings.selectedTheme.colorText)
                    Image(systemName: "\(settings.selectedOperator).circle.fill")
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
                    .focused($isFocused)
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
        .onAppear {
            if settings.answer.isEmpty {
                settings.getNumbers()
            }
        }
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question(isShowingSheet: .constant(false)).environmentObject(GlobalSettings())
    }
}
