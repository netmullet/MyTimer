//
//  SettingView.swift
//  MyTimer
//
//  Created by Otsuka on 2024/06/16.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("timer_value") var timerValue = 10
    var body: some View {
        ZStack {
            Color.backgroundSetting
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("\(timerValue) Seconds")
                    .font(.largeTitle)
                Spacer()
                // 複数の選択肢から1つ選択する
                Picker(selection: $timerValue) {
                    Text("10")
                        .tag(10) // selectionラベルで指定した変数にtagの値が格納される
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                } label: {
                    Text("Select")
                }
                .pickerStyle(.wheel)
            }
        }
    }
}

#Preview {
    SettingView()
}
