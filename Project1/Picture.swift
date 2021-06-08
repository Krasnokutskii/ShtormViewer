//
//  Picture.swift
//  Project1
//
//  Created by Ярослав on 6/8/21.
//

import Foundation

struct Picture: Codable, Comparable{
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        return lhs.amountOfViews > rhs.amountOfViews
    }
    
    var name: String
    var amountOfViews: Int
}
