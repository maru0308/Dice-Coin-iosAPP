

import SwiftUI
import AVFoundation

// CoinViewは、コインを表裏にフリップさせるアニメーションを表示するビューです。
struct CoinView: View {
    @State private var coinImages = ["dollarsign.circle", "dollarsign.circle.fill"]
    @State private var timer: Timer?
    @State private var isRolling = false
    @State private var isRotated = true
    // コイン投げの効果音を読み込む
    private let coinSE = try! AVAudioPlayer(data: NSDataAsset(name: "se_coin_toss2")!.data)
    
    var body: some View {
        VStack {
            Spacer()
            
            // コイン画像を表示する
            Image(systemName: coinImages[0])
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2)
                // 3D回転効果を追加する
                .rotation3DEffect(
                    Angle(degrees: isRotated ? 360 : 0),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                // アニメーションを追加する
                .animation(Animation.linear(duration: 0.4), value: isRotated)
                .padding()
            
            Spacer()
            
            // コイントスボタンを表示する
            Button(action: {
                playCoinSound()
                flipCoin()
            }) {
                Text("コイントス")
            }
            .fontWeight(.bold)
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(50)
            .disabled(isRolling)
            
            Spacer()
        }
    }
    
    // コインをフリップして、ランダムな面を表示する関数
    private func flipCoin() {
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            coinImages.reverse()
            self.isRotated.toggle()
        }
        
        // 2秒後にアニメーションを停止し、ランダムな面を表示する
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            coinImages.shuffle()
            timer?.invalidate()
            timer = nil
            isRolling = false
        }
    }
    
    // コイン投げの効果音を再生する関数
    private func playCoinSound() {
        coinSE.play()
    }
    
}



