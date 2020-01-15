//
//  Helper.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import Foundation

struct Helper {
    static func year(string:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: string){
            formatter.dateFormat = "yyyy"
            return formatter.string(from: date)
        }else{
            return ""
        }
    }
}
