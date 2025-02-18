//
//  ContentView.swift
//  WordScramble
//
//  Created by Omolemo Mashigo on 2025/02/17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word:", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
        }.navigationTitle(rootWord)
            .onSubmit() {
                addNewWord()
            }
        
    }

    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) //prevents adding duplicate words with case differences
        
        //exit if remaining string is empty
        guard answer.count > 0 else{return}
        
        //insert newWord at pos 0 instead of appending so that new words appear in the beginning of the list instead of the end
       
        withAnimation{
            usedWords.insert(newWord, at: 0)
        }
        
        //clear newWord back to being an empty string
        newWord = ""
    }
}

#Preview {
    ContentView()
}
