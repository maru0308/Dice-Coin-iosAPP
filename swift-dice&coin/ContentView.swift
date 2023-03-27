//
//  ContentView.swift
//  swift-dice&coin
//
//  
//

import SwiftUI



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
struct ContentView: View {
    var body: some View {
        
        
        NavigationView{
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    
                    Spacer()
                    
                    
                    BlurView(text: "人生で迷ったら", textSize: 38, startTime: 0.41)
                        .font(.largeTitle)
                    BlurView(text: "サイコロか", textSize: 38, startTime: 1.85)
                        .font(.largeTitle)
                    BlurView(text: "コイントスで", textSize: 38, startTime: 2.76)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    
                    
                    NavigationLink(destination:DiceView().navigationTitle("サイコロ")){
                        Text("サイコロ")
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.size.width / 6 * 4,
                                   height: UIScreen.main.bounds.size.width / 6 * 1)
                    }
                    
                    .foregroundColor(Color(.white))
                    .background(Color(.black))
                    .cornerRadius(90)
                    .overlay(
                        RoundedRectangle(cornerRadius: 90)
                            .stroke(Color(.black), lineWidth: 1.0)
                    )
                    
                    
                    Spacer()
                    
                    //
                    NavigationLink(destination:CoinView().navigationTitle("コイントス")){
                        Text("コイントス")
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.size.width / 6 * 4,
                                   height: UIScreen.main.bounds.size.width / 6 * 1)
                    }
                    
                    .foregroundColor(Color(.white))
                    .background(Color(.black))
                    .cornerRadius(90)
                    .overlay(
                        RoundedRectangle(cornerRadius: 90)
                            .stroke(Color(.black), lineWidth: 1.0)
                    )
                    
                    Spacer()
                    
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
}

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
            ForEach(0..<characters.count,id: \.self) { num in
                Text(String(self.characters[num]))
                    .font(.custom("HiraMinProN-W3", fixedSize: textSize))
                    .blur(radius: blurValue)
                    .opacity(opacity)
                    .animation(.easeInOut.delay( Double(num) * 0.15 ), value: blurValue)
                
                
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
                if blurValue == 0{
                    //                    blurValue = 10
                    //                    opacity = 0.01
                    blurValue = 0
                    opacity = 1
                } else {
                    blurValue = 0
                    opacity = 1
                    
                }
            }
        }
        
    }
}
