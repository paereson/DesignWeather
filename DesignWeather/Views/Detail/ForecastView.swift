//
//  ForecastView.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 26/11/2022.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    var weather: WeatherModel?
    
    var body: some View {    
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Segmented Control
                DesignSegmentedController(selection: $selection)
                
                // MARK: Forecast Card
                if let weather = weather {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12){
                            if selection == 0 {
                                ForEach(weather.list[0...8]) { forecast in
                                    ForecastCard(forecast: Forecast.hourly.first!, weatherList: forecast, forecastPeriod: .hourly)
                                }
                                .transition(.offset(x: -430))
                            } else {
                                ForEach(weather.list) { forecast in
                                    ForecastCard(forecast: Forecast.daily.first!, weatherList: forecast, forecastPeriod: .daily)
                                }
                                .transition(.offset(x: 430))
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .padding(.horizontal, 20)
            
            Text(weather?.city.name ?? "nope")
            
        }
        .backgroundBlur(radius: 25, opague: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            // MARK: Bottom sheet separator
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
