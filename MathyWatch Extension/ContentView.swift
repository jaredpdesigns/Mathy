//
//  ContentView.swift
//  TheseKidsMathWatch Extension
//
//  Created by Jared Pendergraft on 7/17/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var settings = GlobalSettings()
    
    var body: some View {
        VStack(spacing: 0) {
            if settings.solved {
                Answer()
            } else {
                Question()
            }
        }
        .environmentObject(settings)
        .ignoresSafeArea(edges: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .sheet(isPresented: $settings.isShowingSheet, onDismiss: { settings.isShowingSheet = false }) {
            VStack {
                Settings().environmentObject(settings)
            }
        }
        .onAppear {
            if settings.answer == "" {
                settings.getNumbers()
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
