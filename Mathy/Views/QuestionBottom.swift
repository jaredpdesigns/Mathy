//
//  QuestionBottom.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct QuestionBottom: View {
    @ObservedObject var keyboard = KeyboardResponder()
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack {
            TextField("?", text: $settings.answer, onCommit: { settings.checkAnswer() })
                .disableAutocorrection(true)
                .textFieldStyle(.plain)
                .padding()
                .multilineTextAlignment(.center)
                .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .keyboardType(.numbersAndPunctuation)
                .offset(y: -keyboard.currentHeight/2)
        }
        .background(.ultraThickMaterial)
    }
}

@available(iOS 15.0, *)
struct QuestionBottom_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBottom().environmentObject(GlobalSettings())
    }
}
