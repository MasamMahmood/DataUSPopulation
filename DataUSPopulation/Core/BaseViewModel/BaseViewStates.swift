//
//  BaseViewStates.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

protocol ViewStateProtocol: Equatable {
    static var ready: Self { get }
}
