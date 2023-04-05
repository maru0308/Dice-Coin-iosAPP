

import SwiftUI

//タイトルアニメーション
struct BlurView: View {
    let characters: Array<String.Element>
    let baseTime: Double
    let textSize: Double
    @State var blurValue: Double = 10
    @State var opacity: Double = 0
    
    init(text:String, textSize: Double, startTime: Double) {
        characters = Array(text)
        self.textSize = textSize
        baseTime = startTime
    }
    
    var body: some View {
            HStack(spacing: 1){
                // charactersの各文字に対して処理を行う
                ForEach(0..<characters.count,id: \.self) { num in
                    Text(String(self.characters[num]))
                        .font(.custom("HiraMinProN-W3", fixedSize: textSize)) // カスタムフォントの適用
                        .blur(radius: blurValue) // ブラー効果の適用
                        .opacity(opacity) // 不透明度の設定
                        // アニメーションの適用（easeInOutと遅延スタート）
                        .animation(.easeInOut.delay( Double(num) * 0.15 ), value: blurValue)
                }
            }
            .onAppear{
                // baseTime後にblurValueとopacityの値を更新する
                DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
                    blurValue = 0
                    opacity = 1
                }
            }
        }
    }