//
//  BaseViewModel.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

class BaseViewModel<E: ViewStateProtocol>: ObservableObject {
    @Published var states: E = .ready
    @Published var showAlert: Bool = false
    var alertMessage: String = ""
    
    func changeState(_ state: E) {
        DispatchQueue.main.async { [weak self] in
            if self?.states != state {
                self?.states = state
                debugPrint("State changed to \(state)")
            }
        }
    }
}
