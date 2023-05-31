//
//  FetchDataFromJSON.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import Foundation
import UIKit

// Fetching data from provided JSON response
class FetchDataFromJSON {
    
    static let sharedInstance = FetchDataFromJSON()
    
    func readMovieData() -> [MovieModel]? {
        do {
            if let file = Bundle.main.url(forResource: "matrix", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let object = try JSONDecoder().decode([MovieModel].self, from: data)
                
                return object
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
