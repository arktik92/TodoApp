//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Esteban SEMELLIER on 04/01/2023.
//

import SwiftUI

struct AddTaskView: View {
    // Importation CoreDM
    let coreDM: CoreDataManager
    
    // Variables globales
    // @State
    @State var title: String = ""
    @State var task: String = ""
    @State private var lastTime = Date.now
    @Binding var items: [Item] 
    @Binding var addTask: Bool
    @State var categorySelection: String = "Maison"
    
    enum CategoryPicker: String, Equatable, CaseIterable {
        case maison = "Maison", travail = "Travail", perso = "Personnel", kids = "Enfants"
    }
    
    private func populateItems() {
        items = coreDM.getAllItems()
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Titre", text: $title)
                    TextField("Description", text: $task, axis: .vertical)
                } header: {
                    Text("Infomations")
                }
                Section {
                    Picker("", selection: $categorySelection) {
                        ForEach(CategoryPicker.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                            
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                     Text("Categorie")
                }
                Section {
                    DatePicker("Date", selection: $lastTime, displayedComponents: .date)
                    DatePicker("Heure", selection: $lastTime, displayedComponents: .hourAndMinute)
                } header: {
                    Text("Date et heure")
                }
            }
            Button {
                coreDM.saveItem(title: title, content: task, done: false, lastTime: lastTime, simpleRightDirection: 0, timestamp: Date.now, category: categorySelection)
                populateItems()
                print("Save: \(items.count)")
                addTask = false
            } label: {
                Text("Valider la tâche")
            }
        }
    }
}
    


struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(coreDM: CoreDataManager(), items: .constant([Item()]), addTask: .constant(false))
    }
}
