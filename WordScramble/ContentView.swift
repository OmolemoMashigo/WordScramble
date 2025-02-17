//
//  ContentView.swift
//  WordScramble
//
//  Created by Omolemo Mashigo on 2025/02/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            Section("Section 1"){
                Text("Static Row 1")
                Text("Static Row 2")
                Text("Static Row 3")
            }
            
            Section("Section 2"){
                ForEach(0..<5){
                    Text("Dynamic row \($0)" )
                }
            }
            
            Section("Section 3"){
                Text("Static Row 4")
                Text("Static Row 5")
                Text("Static Row 6")
            }
        }
    }
}

#Preview {
    ContentView()
}
