//
//  ContentView.swift
//  WeSplit
//
//  Created by Mayur on 04/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountTextFieldIsFocused: Bool
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }
    var totalAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountTextFieldIsFocused)
                    Picker("Select Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section("HOW MUCH DO YOU WANT TO TIP"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total Amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                }
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountTextFieldIsFocused{
                    Button("Done"){
                        amountTextFieldIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
