//
//  ImageView+Extension.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 31/05/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    // Method for loading Image from URL
    // Considering this is just POC I have not handled image cashing here.
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
