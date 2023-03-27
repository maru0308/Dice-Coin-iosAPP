//
//  DiceView.swift
//  swift-dice&coin
//
// 
//

import SwiftUI
import AVFoundation


    
    
    struct DiceView: View {
        @State  var memberArray:[String] = [""]
        @State var DiceNumber = ["die.face.1","die.face.2","die.face.3","die.face.4","die.face.5","die.face.6"]
        @State var timer : Timer?
        @State var isRolling = false
        private let diceSE = try!  AVAudioPlayer(data: NSDataAsset(name: "dropping_a_shogi_piece1")!.data)
        var body: some View {
            
            VStack {
                Spacer()
                
                Image(systemName:DiceNumber[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/2)
                    .padding(5)
                
                if (memberArray.count > 1){
                    Image(systemName:DiceNumber[6])
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/2)
                        .padding(5)
                }
                
                
                if (memberArray.count > 2){
                    Image(systemName:DiceNumber[12])
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/2)
                        .padding(5)
                }
                
                Spacer()
                Button(action: {
                SoundDice()
                    playDice()
                    print(DiceNumber)
                    
                }){
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
                
//                サイコロの数を追加＆削除
                HStack{
                    Button(action: {
                        memberArray.append("")
                        DiceNumber.append(contentsOf:["die.face.1","die.face.2","die.face.3","die.face.4","die.face.5","die.face.6"] )
                        print(DiceNumber)
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)

                    }).foregroundColor(memberArray.count == 3 ? .gray : .black)
                        .padding(20)
                        .disabled(memberArray.count == 3)
                                            
                    
                    Button(action: {
                        memberArray.removeLast()
                        DiceNumber.removeSubrange(0...5)
                        
                        print(DiceNumber)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }).foregroundColor(memberArray.count == 1 ? .gray : .black)
                        .padding(20)
                        .disabled(memberArray.count == 1)
                    
                }
            }
        }
        
        //    サイコロの数をランダムに取得&サイコロのアニメーション
        func playDice(){
            
            isRolling = true
            timer = Timer.scheduledTimer(withTimeInterval:0.1, repeats: true){
                _ in  DiceNumber.shuffle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                timer?.invalidate()
                timer = nil
                isRolling = false
                
            }
        }
//        サイコロSE
        private func SoundDice(){
                diceSE.play()
            }
        
        
        
    }

