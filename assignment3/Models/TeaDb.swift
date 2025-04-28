//
//  TeaDb.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

class TeaDb: ObservableObject {
    var teas: [TeaModel] = getTeas()
    
    func getBy(type: TeaType) -> [TeaModel] {
        return teas.filter({$0.type == type})
    }
    
    static func getTeas() -> [TeaModel] {
        // This will eventually need to read from a json file
        let tea1 = TeaModel(id: 0, name: "English Caramel", type: .black, waterAmount: 250, waterTemp: 100, time: 180, url: "https://www.lupicia.com.au/22/black-tea-flavoured/194/english-caramel")
        let tea2 = TeaModel(id: 1, name: "Spices", type: .black, waterAmount: 250, waterTemp: 100, time: 180, url: "https://www.lupicia.com.au/22/black-tea-flavoured/195/spices-chai-style")
        let tea3 = TeaModel(id: 2, name: "Sencha Chiran", type: .green, waterAmount: 250, waterTemp: 60, time: 60, url: "https://www.lupicia.com.au/17/japanese-green-tea/75/sencha-chiran")
        let tea4 = TeaModel(id: 3, name: "Momo Oolong", type: .oolong, waterAmount: 250, waterTemp: 100, time: 180, url: "https://www.lupicia.com.au/178/momo-oolong-collection/99/momo-oolong-super-grade")
        let tea5 = TeaModel(id: 4, name: "Speed tea", type: .green, waterAmount: 0, waterTemp: 25, time: 5, url: "https://example.com")
        
        return [tea1, tea2, tea3, tea4, tea5]
    }
}
