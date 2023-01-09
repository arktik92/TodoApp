//
//  cardView.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 06/01/2023.
//

import SwiftUI

struct cardView: View {
    var title: String
    var content: String
    var date: Date
    var done: Bool
    var body: some View {
        VStack {
//            RoundedRectangle(cornerRadius: 15)
            Rectangle()
                .foregroundColor(Color(red: Double.random(in: 0.5...1), green: Double.random(in: 0.5...1), blue: Double.random(in: 0.5...1)))
                .frame(height: 200)
//                .shadow(radius: 7, x: 10, y: 10)
                .overlay(
                    HStack {
                        VStack {
                            Text(title)
                                .font(.title2)
                                .padding(.bottom)
                            Text(content)
                            Text("Echéance le : \(date, formatter: itemFormatter )")
                                .padding(.top)
                        }
//                        .padding(.vertical)
                        Spacer()
                        VStack {
                            Circle()
                                .padding(.vertical)
                                .frame(height: 80)
                                .foregroundColor(.cyan)
                                .overlay(
                                    Text(done ?  "done" : "Todo")
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .padding(.horizontal)
                )
             
        }
        .ignoresSafeArea()
//        .background(
////            Image("back")
////                .resizable()
////                .aspectRatio( contentMode: .fill)
////                .ignoresSafeArea()
//            Color.indigo
//        )
    }
}

struct cardView_Previews: PreviewProvider {
    static var previews: some View {
        cardView(title: "test extract", content: "youhouuuuuu", date: Date.now, done: false)
    }
}
