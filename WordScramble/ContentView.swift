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
    
    //alert variables
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
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
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: {
                startGame()
            })
            .alert(errorTitle, isPresented: $showError){
                Button("OK"){}
            } message: {
                Text(errorMessage )
            }
        }
        
    }

    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) //prevents adding duplicate words with case differences
        
        //exit if remaining string is empty
        guard answer.count > 0 else{return}
        
        guard isWordOriginal(word: answer)else {
            wordError(title: "word already used", message: "try being more original")
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "word not possible", message: "you can't spell that word from \(rootWord)")
            return
        }
        
        guard isRealWord(word: answer) else{
            wordError(title: "that's not a real word ", message: "please use a real English word")
            return
        }
        
        //insert newWord at pos 0 instead of appending so that new words appear in the beginning of the list instead of the end
        withAnimation{
            usedWords.insert(newWord, at: 0)
        }
        
        //clear newWord back to being an empty string
        newWord = ""
    }
    
    func startGame(){
        if let startUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startUrl){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "launches"
                return
            }
        }
        //something went wrong
        fatalError("could not load start.txt from bundle")
    }
    
    
    //return true or false depending on whether the word has been used before or not
    func isWordOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    //create a variable copy of the root word, we can then loop over each letter of the user’s input word to see if that letter exists in our copy
    func isPossible(word: String) -> Bool{
        var temp = rootWord
        
        for letter in word{
            if let pos = temp.firstIndex(of: letter){ //if we find letter inside temp, put the position of the letter into pos
                temp.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isRealWord(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

#Preview {
    ContentView()
}
