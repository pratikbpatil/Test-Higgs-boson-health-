//
//  FetchDataFromJSON.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import Foundation
import UIKit

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

//  MARK: UIImageView Extension
extension UIImageView {
    
    //     Method for loading Image from URL
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
