//
//  DataPopulationViewModelTest.swift
//  DataUSPopulationTests
//
//  Created by Masam Mahmood on 25/10/2024.
//

import XCTest
import Combine
@testable import DataUSPopulation

class DataPopulationViewModelTest: XCTestCase {
    
    private var viewModel: DataPopulationViewModel!
    private var cancellable: AnyCancellable?
    private var filename = "NationResponse"
    private let isloadingExpectation = XCTestExpectation(description: "isLoading true")
    
    override func setUp() {
        super.setUp()
        viewModel = DataPopulationViewModel(service: MockHttpClient(filename: filename, service: Mock()))
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_ready_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "state ready",
                                     equals: [{ $0 == .ready}])
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_finished_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "state finished",
                                     equals: [{ $0 == .finished}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_loading_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "state loading",
                                     equals: [{ $0 == .loading}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_error_State() {
       filename = "error"
       setUp()
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "state error",
                                     equals: [{ $0 == .error}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_ShowingAlert() {
       filename = "error"
       setUp()
        viewModel.serviceInitialize()
       
       cancellable = viewModel.objectWillChange.eraseToAnyPublisher().sink { _ in
           XCTAssertEqual(self.viewModel.showAlert, true)
           self.isloadingExpectation.fulfill()
       }
       wait(for: [isloadingExpectation], timeout: 1)
   }
}
