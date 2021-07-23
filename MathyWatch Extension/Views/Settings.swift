//
//  Settings.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        List {
            Section(header: Text("Operators")) {
                ForEach(operators, id: \.self) { item in
                    HStack {
                        Label {
                            Text(item.name)
                        } icon: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.white)
                                Image(systemName: "\(item.image).circle.fill")
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                        if item.image == settings.selectedOperator {
                            Image(systemName: "checkmark")
                                .imageScale(.small)
                                .foregroundColor(settings.selectedTheme.colorBG)
                        }
                        
                    }
                    .background(Color.clear)
                    .onTapGesture {
                        settings.setOperator(value: item.image)
                    }
                }
            }
            Section(header: Text("Themes")) {
                ForEach(themes, id: \.self) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        if item == settings.selectedTheme {
                            Image(systemName: "checkmark")
                                .imageScale(.small)
                                .foregroundColor(settings.selectedTheme.colorBG)
                        }
                        
                    }
                    .onTapGesture {
                        settings.setTheme(theme: item)
                    }
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(GlobalSettings())
    }
}
