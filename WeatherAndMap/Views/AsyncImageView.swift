//
//  AsyncImageView.swift
//  WeatherAndMap
//
//  Created by hitoshi on 2025/02/16.
//

import SwiftUI

struct AsyncImageView: View {
    let urlStr: String // 画像URLの文字列を受けとる定数
    var body: some View {
        // URL型に変換できたらAsyncImageで画像を取得
        if let url = URL(string: urlStr) {
            AsyncImage(url: url) { image in
                image //
                    .resizable()
            } placeholder: { // 画像が無いときや読み込み中の表示
                ProgressView() // 進捗とかのインジケータのビュー
                    .scaledToFit()
            }
        } else {
            Text("No Image")
        }
    }
}

#Preview {
    // 八幡平市の市章画像のURL文字列
    let urlStr = "https://www.city.hachimantai.lg.jp/img/common/top_logo.png"
    AsyncImageView(urlStr: urlStr)
}
