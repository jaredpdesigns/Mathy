//
//  ContentView.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var settings = GlobalSettings()
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if settings.solved {
                Answer()
            } else {
                Question(isShowingSheet: $isShowingSheet)
            }
        }
        .environmentObject(settings)
        .ignoresSafeArea(edges: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingSheet, onDismiss: { self.isShowingSheet = false }) {
            VStack {
                Settings().environmentObject(settings)
            }
        }
        .onChange(of: settings.selectedOperator) { _ in
            settings.getSolution()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
