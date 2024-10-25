//
//  BaseView.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import SwiftUI

struct BaseView<Content: View, ViewState:ViewStateProtocol, VM: BaseViewModel<ViewState>>: View {
    
    @ObservedObject var baseViewModel: VM
    private let content: Content
    private var bgColor: Color = .white
    
    init(viewModel: VM, @ViewBuilder content: () -> Content) {
        _baseViewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            bgColor.edgesIgnoringSafeArea(.all)
            content
        }
        .alert(isPresented: $baseViewModel.showAlert) {
            Alert(
                title: Text("Warning"),
                message: Text(baseViewModel.alertMessage),
                dismissButton: .default(Text("ok"))
            )
        }
    }
}

extension BaseView {
    func setBg(color: Color) -> Self {
        var view = self
        view.bgColor = color
        return view
    }
}
