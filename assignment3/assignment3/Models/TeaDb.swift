//
//  TeaDb.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

class TeaDb: ObservableObject {
    var teas: [TeaModel] = []
    
    func getBy(type: TeaType) -> [TeaModel] {
        return teas.filter({$0.type == type})
    }
}
