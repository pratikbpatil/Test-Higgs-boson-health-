//
//  Int+Extension.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 30/05/23.
//

import Foundation

extension Int {
    func minutesToHHMM() -> (hours: Int , leftMinutes: Int) {
        return (self / 60, (self % 60))
    }
}
