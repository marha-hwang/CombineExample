//
//  ContentView.swift
//  CombineExample
//
//  Created by haram on 2/1/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Combine활용 예제모음")){
                    NavigationLink("Combine활용 예제 모음", destination: LoginVerify())
                }
            }
            .navigationTitle("Combine Example")
        }
        
    }
}
