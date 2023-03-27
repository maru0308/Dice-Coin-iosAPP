//
//  CoinView.swift
//  swift-dice&coin
//
//  
//

import SwiftUI
import AVFoundation

struct CoinView: View {
    
    @State var randomCoin = ["dollarsign.circle","dollarsign.circle.fill"]
    @State var timer : Timer?
    @State var isRolling = false
    @State private var isRotatedSq = true
    private let coinSE = try!  AVAudioPlayer(data: NSDataAsset(name: "se_coin_toss2")!.data)
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: randomCoin[0] )
                .resizable()
                .scaledToFit()
                .frame(width:UIScreen.main.bounds.width/2)
            //            コイントスのアニメーション
                .rotation3DEffect(Angle(degrees:isRotatedSq ? 360:0), axis: (x:10.0, y:0.0, z:0.0))
                .animation(Animation.linear(duration: 0.4), value: isRotatedSq)
                .padding()
            
            Spacer()
            
            Button(action: {
                playSound()
                playCoin()
                
            }){
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
        
        Spacer()
    }
    
    //    コインの裏表をランダムに取得、表示
    func playCoin(){
        
        
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in  randomCoin.reverse()
            self.isRotatedSq.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            randomCoin.shuffle()
            timer?.invalidate()
            timer = nil
            isRolling = false
        }
    }
    
//    コイントスSE
    private func playSound(){
            coinSE.play()
        }
    
}


