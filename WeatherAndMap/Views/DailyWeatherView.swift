//
//  DailyWeatherView.swift
//  WeatherAndMap
//
//  Created by hitoshi on 2025/02/16.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel // APIレスポンスの値を保持するオブジェクト
    
    var body: some View {
        ScrollView(.horizontal) { // 水平方向(.horizontal)にスクロールする
            
            // レスポンスに天気予報の情報があるかどうかで場合分け
            if let forecastsDay = weatherVM.forecast?.forecastsDay {
                HStack {
                    ForEach(forecastsDay, id: \.self) { forecastDay in // 日数分繰り返す
                        VStack(spacing: 5) {
                            // MARK: - 1日分の天気予報のUI
                            Text(forecastDay.toDisplayDate(forecastDay.date)) // 日付(年月日)
                                .font(.callout) // フォントをコールアウトのスタイルに
                            
                            // 天気アイコン画像
                            AsyncImageView(urlStr: "https:\(forecastDay.day.condition.icon)")
                                .padding()
                                .scaledToFit()
                            
                            Text(forecastDay.day.condition.text) // 天気の説明(晴れ、曇り 等)
                                .font(.headline) // フォントを見出しのスタイルに
                            
                            // 最高気温 °C / 最低気温 °C
                            HStack {
                                Text(forecastDay.day.maxTemp, format: .number) // 数字が入る
                                    .foregroundStyle(.red) // 文字を赤に
                                Text("°C")
                                    .foregroundStyle(.red) // 文字を赤に
                                Text(forecastDay.day.minTemp, format: .number) // 数字が入る
                                    .foregroundStyle(.blue) // 文字を青に
                                Text("°C")
                                    .foregroundStyle(.blue) // 文字を青に
                            }
                            
                            // 降水確率: ○○ %
                            HStack {
                                Text("降水確率:")
                                Text(forecastDay.day.dailyChanceOfRain, format: .number) // 数字が入る
                                Text("%")
                            }
                            .font(.subheadline) // フォントを小見出しのスタイルに
                        }
                        .padding()
                        .frame(width: ScreenInfo.width / 2, height: ScreenInfo.height / 3)
                        .background(.yellow.opacity(0.3)) // 背景色
                        .clipShape(.rect(cornerRadius: 10)) // 角丸に切り取る
                    }
                }
            } else {
                // コピペした部分。データが無いとき(または起動直後)に表示。
                HStack {
                    ForEach(0...2, id: \.self) { _ in // 3回繰り返して表示
                        VStack(spacing: 5) {
                            // MARK: - 1日分の天気予報のUI
                            Text("____年__月__日") // 日付(年月日)
                            
                            Image(systemName: "cloud.sun") // 天気アイコン(サンプル画像)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                            
                            Text("晴れのち曇り") // 天気の説明(晴れ、曇り 等)
                            
                            // 最高気温 °C / 最低気温 °C
                            HStack {
                                Text("最高") // 数字が入る
                                Text("°C")
                                Text("最低") // 数字が入る
                                Text("°C")
                            }
                            
                            // 降水確率: ○○ %
                            HStack {
                                Text("降水確率:")
                                Text("○○") // 数字が入る
                                Text("%")
                            }
                        }
                        .padding()
                        .frame(width: ScreenInfo.width / 2, height: ScreenInfo.height / 3)
                        .background(.yellow.opacity(0.3)) // 背景色
                        .clipShape(.rect(cornerRadius: 10)) // 角丸に切り取る
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var weatherVM = WeatherViewModel()
    // 八幡平市大更の緯度・経度
    let lat: Double = 39.91167
    let lon: Double = 141.093459
    
    DailyWeatherView(weatherVM: weatherVM)
        .onAppear {
            weatherVM.request3DaysForecast(lat: lat, lon: lon)
        }
}
