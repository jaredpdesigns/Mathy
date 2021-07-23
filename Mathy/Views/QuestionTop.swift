//
//  QuestionTop.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI

struct QuestionTop: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack {
            HStack {
                Text("\(settings.numberOne)")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(settings.selectedTheme.colorText != nil ? .white:Color(UIColor.systemBackground))
                    Image(systemName: "\(settings.selectedOperator).circle.fill")
                }
                .font(Font.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 108:64))
                .imageScale(.small)
                Text("\(settings.numberTwo)")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(settings.selectedTheme.colorText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor)
    }
}

struct QuestionTop_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTop().environmentObject(GlobalSettings())
    }
}
