//
//  QuestionBottom.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI

struct QuestionBottom: View {
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
                .foregroundColor(settings.selectedTheme.colorText)
        }
    }
}

struct QuestionBottom_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBottom().environmentObject(GlobalSettings())
    }
}
