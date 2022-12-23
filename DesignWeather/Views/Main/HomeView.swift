//
//  HomeView.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/11/2022.
//

import SwiftUI
import Combine
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    var bottomSheetTranslationProrated: CGFloat {
        let prorated = (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
        return prorated > 0 ? prorated : 0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                ZStack {
                    // MARK: Background color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text(viewModel.weather?.city.name ?? "")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)
                            
                            Text("H:\(Int(viewModel.weather?.list.first?.main.temp_max ?? 0))°   L:\(Int(viewModel.weather?.list.first?.main.temp_min ?? 0))°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    // MARK: Bottom sheet
                    BottomSheetView(position: $bottomSheetPosition) {
                        
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation {
                            hasDragged = bottomSheetPosition == .top ? true : false
                        }
                    }
                    
                    // MARK: TabBar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    var attributedString: AttributedString {
        let temp = Int(viewModel.weather?.list.first?.main.temp ?? 0)
        let weatherMain = viewModel.weather?.list.first?.weather.first?.main ?? ""
        let weatherDesc = viewModel.weather?.list.first?.weather.first?.description ?? ""
        let weatherString = "\(weatherMain) | \(weatherDesc)"
        
        var string = AttributedString("\(temp)°" + (hasDragged ? " | " : "\n ") + weatherString)
        
        if let temp = string.range(of: "\(temp)°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: weatherString) {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
