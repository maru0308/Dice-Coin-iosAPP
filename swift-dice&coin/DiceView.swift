

import SwiftUI
import AVFoundation


// DiceViewは、サイコロをロールさせるアニメーションを表示するビューです。
struct DiceView: View {
    @State private var memberArray: [String] = [""]
    @State private var diceFaces = [
        "die.face.1",
        "die.face.2",
        "die.face.3",
        "die.face.4",
        "die.face.5",
        "die.face.6"
    ]
    @State private var timer: Timer?
    @State private var isRolling = false
    // サイコロを振る効果音を読み込む
    private let diceSE = try! AVAudioPlayer(data: NSDataAsset(name: "dropping_a_shogi_piece1")!.data)
    
    var body: some View {
        VStack {
            Spacer()
            
            // 各メンバーに対してサイコロ画像を表示する
            ForEach(memberArray.indices, id: \.self) { index in
                Image(systemName: diceFaces[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/2)
                    .padding(5)
            }
            
            Spacer()
            
            // サイコロを振るボタン
            Button(action: {
                playDiceSound()
                rollDice()
            }) {
                Text("サイコロを振る")
                    .fontWeight(.bold)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                    .padding(20)
            }
            .disabled(isRolling)
            
            Spacer()
            
            // サイコロを追加・削除するボタン
            HStack {
                Button(action: {
                    addDice()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                })
                
                .foregroundColor(memberArray.count == 3 ? .gray : .black)
                .padding(20)
                .disabled(memberArray.count == 3)
                
                Button(action: {
                    removeDice()
                }, label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                })
                .foregroundColor(memberArray.count == 1 ? .gray : .black)
                .padding(20)
                .disabled(memberArray.count == 1)
            }
        }
    }
    
    // アニメーション付きでサイコロを振る関数
    private func rollDice() {
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            diceFaces.shuffle()
        }
        
        // 0.7秒後にアニメーションを停止する
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            timer?.invalidate()
            timer = nil
            timer = nil
            isRolling = false
        }
    }
    
    // サイコロを振る効果音を再生する関数
    private func playDiceSound() {
        diceSE.play()
    }
    
    // 新しいメンバーのためにサイコロを追加する関数
    private func addDice() {
        if memberArray.count < 3 {
            memberArray.append("")
        }
    }
    
    // メンバーのサイコロを削除する関数
    private func removeDice() {
        if memberArray.count > 1 {
            memberArray.removeLast()
        }
    }
}
