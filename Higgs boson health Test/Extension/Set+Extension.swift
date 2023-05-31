//
//  Set+Extension.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 30/05/23.
//

import Foundation
import Combine

typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    mutating func cancelAll() {
        forEach { $0.cancel()}
        self.removeAll()
    }
}
