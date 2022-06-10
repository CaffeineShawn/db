//
//  GoodsViewModel.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//

import SwiftUI

final class GoodsViewModel: ObservableObject {
    @Published var goods: [Good] = []
    

    func updateGood(good: Good) async throws {
        guard let url = URL(string: BaseURL.base.rawValue + EndPoints.updateGood.rawValue) else {
            throw HttpErrors.badUrl
        }
        
        try await sendData(url: url, object: good, method: HttpMethods.PUT.rawValue)
    }
    
}
