//
//  DetailCardView.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 08/01/2023.
//

import SwiftUI

struct DetailCardView: View {
    var item: Item
    var body: some View {
        VStack {
            Text("Catégorie : \(item.category!)")
                .padding(50)
            Text("Echéance le :  \(item.lastTime!, formatter: itemFormatter)" )
            // TODO: Timer a regler
            
            Text(item.content!)
        }
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.clear)

            
    }
}

struct DetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardView(item: Item())
    }
}
