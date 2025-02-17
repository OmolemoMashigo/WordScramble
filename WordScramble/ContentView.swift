//
//  ContentView.swift
//  WordScramble
//
//  Created by Omolemo Mashigo on 2025/02/17.
//

import SwiftUI

struct ContentView: View {
    
    let boys = ["Thabo", "Rey", "Matt"]
    
    var body: some View {
        //if list is only made up of dynamic content
        List(boys, id: \.self){
            Text($0)
        }
        
    }
}

#Preview {
    ContentView()
}
