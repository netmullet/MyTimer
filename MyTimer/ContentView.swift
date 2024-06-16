//
//  ContentView.swift
//  MyTimer
//
//  Created by Otsuka on 2024/06/16.
//

import SwiftUI

struct ContentView: View {
    // Timer型の変数
    @State var timerHandler: Timer?
    @State var count = 0
    // データを永続化するUserDefaultsから値の読み込みを行う
    @AppStorage("timer_value") var timerValue = 10
    @State var showAlert = false
    
    var body: some View {
        // 画面遷移を管理する
        NavigationStack {
            ZStack {
                Image(.backgroundTimer)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack (spacing: 30.0) {
                    Text("\(timerValue - count) Seconds Left")
                        .font(.largeTitle)
                    HStack {
                        Button {
                            startTimer()
                        } label: {
                            Text("Start")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.start)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                        Button {
                            if let timerHandler {
                                if timerHandler.isValid == true {
                                    timerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("Stop")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.stop)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            .onAppear {
                count = 0
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Text("Setting")
                    }
                }
            }
            // 状態変数showAlertがtrueになったときに実行される
            .alert("Finish!", isPresented: $showAlert) {
                Button("OK") {
                    print("OK Tapped")
                }
            } message: {
                Text("Timer Ended")
            }
        }
    }
    
    func countDownTimer() {
        count += 1
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
            showAlert = true
        }
    }
    
    func startTimer() {
        // timerHandlerをアンラップ
        if let timerHandler {
            // タイマーが実行中であれば、何もしない
            if timerHandler.isValid == true {
                return
            }
        }
        if timerValue - count <= 0 {
            count = 0
        }
        // タイマーをスタートする
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // 1秒毎に呼び出す
            countDownTimer()
        }
    }
}

#Preview {
    ContentView()
}
