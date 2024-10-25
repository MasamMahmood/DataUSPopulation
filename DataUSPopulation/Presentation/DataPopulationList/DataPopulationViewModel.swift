//
//  DataPopulationViewModel.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - DataPopulationViewModel
final class DataPopulationViewModel: BaseViewModel<DataPopulationList> {
    
    private var service:  DataListServiceable?
    var allNation: [NationData] = []
    var allState: [StateData] = []
    
    init(service: DataListServiceable =  DataPopulationListService(service: HttpClient())) {
        self.service = service
    }
    
    func serviceInitialize() {
        fetchAllData()
    }
    
    private func fetchAllData() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service?.fetchAllNation()
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let nation = success.data else { return self.changeState(.empty) }
                DispatchQueue.main.async {
                    self.allNation = nation
                    self.changeState(nation.count == 0 ? .empty : .finished)
                    self.fetchStateList()
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            case .none:
                fatalError()
            }
        }
    }
    
    private func fetchStateList() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service?.fetchAllState()
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let state = success.data else { return self.changeState(.empty) }
                DispatchQueue.main.async {
                    self.allState = state
                    self.changeState(state.count == 0 ? .empty : .finished)
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            case .none:
                fatalError()
            }
        }
    }
}
