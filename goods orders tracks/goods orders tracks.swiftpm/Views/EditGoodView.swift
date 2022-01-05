//
//  EditGoodView.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//

import SwiftUI

struct EditGoodView: View { 
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @State var goodName: String
    @State var goodId: Int
    @State var goodPrice: Double
    @State var goodWeight: Double
    private let numberFormatter: NumberFormatter
    private let massFormatter: NumberFormatter
    init(goodName: String, goodId: Int, goodPrice: Double, goodWeight: Double) {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        massFormatter = NumberFormatter()
        massFormatter.numberStyle = .decimal
        massFormatter.allowsFloats = true
        _goodName = State(initialValue: goodName)
        _goodId = State(initialValue: goodId)
        _goodPrice = State(initialValue: goodPrice)
        _goodWeight = State(initialValue: goodWeight)
        
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("货物名称")) {
                    TextField("货物名称", text: $goodName)}
                Section(header: Text("货物价格")) {
                    TextField("货物价格", value: $goodPrice, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    Stepper("调整货物价格", onIncrement: {
                        goodPrice += 0.1
                    }, onDecrement: {
                        goodPrice -= 0.1
                    })
                    
                }
                Section(header: Text("货物重量"))  {
                    HStack {
                        TextField("0.00", value: $goodWeight, formatter: massFormatter)
                            .keyboardType(.numberPad)
                        Spacer()
                        Text("kg")
                    }
                    Stepper("调整货物重量", onIncrement: {
                        goodWeight += 0.1
                    }, onDecrement: {
                        goodWeight -= 0.1
                    })
                
                }
                Button {
                    print(goodWeight)
                    Task {
                        try await ordersViewModel.updateGood(good: Good(id: goodId, name: goodName, weight: goodWeight, price: goodPrice))
                    }
                    dismiss()
                } label: {
                    Text("Submit")
                        .foregroundColor(.accentColor)
                }
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }

            }
        }
    }
}
