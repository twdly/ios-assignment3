//
//  TeaDb.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

import Foundation

class TeaDb: ObservableObject {
    @Published var teas: [TeaModel] = []
    var timerDict: [Int: Date] = [:]
    //Intiate Tea database when application is launched
    //If this is the first launch copy defualt json file to local file system
    init() {
        copyTeasToDocumentsIfNeeded()
        teas = loadTeas()
    }

    //Get tea information (by id)
    func getBy(id: Int) -> TeaModel? {
        teas.first { $0.id == id }
    }
    //get tea information (by model)
    func getBy(category: TeaCategory) -> [TeaModel] {
        teas.filter { $0.category == category }
    }
    
    //add a new tea to database
    func addTea(_ tea: TeaModel) {
        teas.append(tea)
        saveTeas(teas)
        teas = loadTeas()
    }

    //update a tea that already exists in database
    func updateTea(_ tea: TeaModel) {
        if let index = teas.firstIndex(where: { $0.id == tea.id }) {
            teas[index] = tea
            saveTeas(teas)
            teas = loadTeas()
        }
    }

    //delete a tea from the database
    func deleteTea(id: Int) {
        teas.removeAll { $0.id == id }
        saveTeas(teas)
        teas = loadTeas()
    }
    
    //brew a tea and update the qunatity stocked
    func brewTea(id: Int) {
        if let index = teas.firstIndex(where: { $0.id == id }) {
            var tea = teas[index]
            tea.amountStocked = max(tea.amountStocked - tea.teaUsedPerBrew, 0)
            teas[index] = tea
            saveTeas(teas)
        }
    }
    
    func restockTea(id: Int, amount: Int) {
        if let index = teas.firstIndex(where: { $0.id == id }) {
            teas[index].amountStocked += amount
            saveTeas(teas)
        }
    }
}


//finds the location of the TeaData.json in the file structure and returns the full url
func teaFileURL() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("TeaData.json")
}

//this function is used to move the defualt json file into local device storage so it can be edited
//for persistance across devices this would need to be changed
func copyTeasToDocumentsIfNeeded() {
    let fileManager = FileManager.default
    let destURL = teaFileURL()

    if let bundleURL = Bundle.main.url(forResource: "TeaData", withExtension: "json") {
        do {
            if fileManager.fileExists(atPath: destURL.path) {
                try fileManager.removeItem(at: destURL)
                print("🗑️ Removed old TeaData.json")
            }
            try fileManager.copyItem(at: bundleURL, to: destURL)
            print("✅ Copied fresh TeaData.json to Documents")
        } catch {
            print("❌ Error copying TeaData.json: \(error)")
        }
    }
}

//Loads the json in to a TeaModels array
func loadTeas() -> [TeaModel] {
    let url = teaFileURL()
    do {
        let data = try Data(contentsOf: url)
        print("✅ Loaded JSON data: \(data.count) bytes")

        let teas = try JSONDecoder().decode([TeaModel].self, from: data)
        print("✅ Successfully decoded \(teas.count) teas")
        return teas
    } catch {
        print("❌ Error loading teas: \(error)")
        return []
    }
}

//
func saveTeas(_ teas: [TeaModel]) {
    let url = teaFileURL()
    do {
        let data = try JSONEncoder().encode(teas)
        try data.write(to: url, options: [.atomicWrite])
    } catch {
        print("Error saving teas: \(error)")
    }

}



