//
//  DataPopulationView.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import SwiftUI
import Charts

struct DataPopulationView: View {
    
    @ObservedObject private var viewModel: DataPopulationViewModel
    let rows = [
        GridItem(.adaptive(minimum: 150),
                 spacing: 15),
        GridItem(.adaptive(minimum: 150),
                 spacing: 15)
    ]
    
    init() {
        self._viewModel = ObservedObject(wrappedValue: DataPopulationViewModel())
    }
    
    var body: some View {
        BaseView(viewModel: viewModel){
            ContentView()
        }
        .onAppear {
            viewModel.serviceInitialize()
            
        }
        
    }
    
    private func ContentView() -> some View {
        ScrollView(showsIndicators: false) {
            NationWiseDataView()
            StateWiseDataView()
        }
    }
    
    // MARK: NationWise
    private func NationWiseDataView() -> some View {
        VStack {
            Text("US Nation Wise Yearly Population Data")
                .font(.title2)
                .padding(.top, 20)
            
            Chart(viewModel.allNation) { item in
                SectorMark(
                    angle: .value("Population", item.population),
                    innerRadius: .ratio(0.6),
                    angularInset: 2
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Year", item.year))
                .annotation(position: .overlay) {
                    Text(item.population, format: .number.notation(.compactName))
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }
            .scaledToFit()
            .chartLegend(alignment: .center, spacing: 16)
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                        let frame = geometry[anchor]
                        Text("US Population")
                            .position(x: frame.midX, y: frame.midY)
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: StateWise
    private func StateWiseDataView() -> some View {
        VStack {
            Text("State Wise Population Data")
                .font(.title2)
                .padding(.top, 40)
                .padding(.bottom, 10)
            
            Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 15, verticalSpacing: 10) {
                GridRow {
                    Text("State")
                    Text("Year")
                    Text("Population")
                }.font(.title3)
                
                Divider()
                
                ForEach(viewModel.allState) { states in
                    GridRow {
                        Text(states.state)
                            .bold()
                        Text(states.year)
                        Text("\(states.population)")
                    }
                }
            }.padding()
            
        }
    }
}

#Preview {
    DataPopulationView()
}
