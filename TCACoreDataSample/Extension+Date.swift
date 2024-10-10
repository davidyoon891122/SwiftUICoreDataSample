//
//  Extension+Date.swift
//  TCACoreDataSample
//
//  Created by Davidyoon on 10/10/24.
//

import Foundation

extension Date {
    
    var currentStringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년MM월dd일 EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}
