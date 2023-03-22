//
//  ContentView.swift
//  WeSplit
//
//  Created by Tuğran on 19.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let total = (checkAmount + ((checkAmount * tipSelection) / 100)) / peopleCount
        return total
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Paylaşmak istediğiniz tutarı giriniz", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Kişi sayısını giriniz", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) Kişi")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage:", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Bahşiş miktarı ?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
