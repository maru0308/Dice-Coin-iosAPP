//
//  SoundDice.swift
//  swift-dice&coin
//
//  Created by 丸岡賢史 on 2022/12/01.
//
//import UIKit
//import AVFoundation
//
//class SoundPlayer: NSObject {
//    
//    let music_data=NSDataAsset(name: "dropping_a_shogi_piece1")!.data   // 音源の指定
//    var music_player:AVAudioPlayer!
//    
//    // 音楽を再生
//    func musicPlayer(){
//        
//        do{
//            music_player=try AVAudioPlayer(data:music_data)   // 音楽を指定
//            music_player.play()   // 音楽再生
//        }catch{
//            print("エラー発生.音を流せません")
//        }
//        
//    }
//}
