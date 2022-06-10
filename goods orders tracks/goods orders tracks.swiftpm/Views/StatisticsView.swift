//
//  SwiftUIView.swift
//  
//
//  Created by Shaw Young on 2021/12/30.
//

import SwiftUICharts
import SwiftUI
import UniformTypeIdentifiers

struct StatisticsView: View {
    @EnvironmentObject var ordersViewModel: OrdersViewModel

    @State private var showingFileImporter =  false
    
    @State private var chartData: PieChartData = PieChartData(dataSets: PieDataSet(dataPoints: [PieChartDataPoint(value: 1)], legendTitle: ""), metadata: ChartMetadata())
    
    
    
    func load() {
        Task {
            try await ordersViewModel.fetchOrdersWithGoods()
        }
        
        chartData = orderPieData(groupOrdersByState: groupOrdersByState(ordersWithGoods: ordersViewModel.ordersWithGoods))
    }
    
    var body: some View {
        
        NavigationView {
            List {
                VStack {
                
                    PieChart(chartData: chartData)
                }
               
                .touchOverlay(chartData: chartData)
                .headerBox(chartData: chartData)
                .legends(chartData: chartData, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                .id(chartData.id)
                .padding(.horizontal)
                
                Button {
                    showingFileImporter.toggle()
                } label: {
                    HStack {
                        Image(systemName: "cloud")
                        Text("上传订单")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
          
            }

            .onAppear {
               load()
            }
            .refreshable {
              load()
            }
            .navigationTitle("Statistics")
            .fileImporter(isPresented: $showingFileImporter, allowedContentTypes: [.xlsx]) { result in
                if case .success = result {
                    Task {
                        do {
                            let fileUrl = try result.get()
                            let webUrl: URL =  URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.uploadExcel.rawValue)!
                            try await
                            uploadFile(fileUrl: fileUrl, webUrl: webUrl)
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                } else {
                    
                }
            }

        }
      
    }
}

fileprivate extension UTType {
    static var xlsx = UTType(tag: "xlsx", tagClass: .filenameExtension, conformingTo: .data)!
}


