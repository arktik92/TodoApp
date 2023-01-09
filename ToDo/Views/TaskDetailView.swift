//
//  TaskDetailView.swift
//  ToDoApp
//
//  Created by Esteban SEMELLIER on 04/01/2023.
//

import SwiftUI


struct TaskDetailView: View {
    
    var coreDM: CoreDataManager
    @State var item: Item
    
    // Variables Globale
    @Environment(\.presentationMode) var presentationMode
    
    //    @Binding var done: Bool
    @State var alertPresented: Bool = false
    @State var editMode: Bool = false
    @Binding var needsRefresh: Bool
    
    // Slider
    @State private var simpleRightDirectionSliderOffsetX: CGFloat = 0
    
    // TODO: Timer
    let fmt = ISO8601DateFormatter()
    @State var currentDate = Date.now
    @State var timer = DateComponents()
    
    // Category Picker
    @State var categorySelection: String = "Maison"
    
    enum CategoryPicker: String, Equatable, CaseIterable {
        case maison = "Maison", travail = "Travail", perso = "Personnel", kids = "Enfants"
    }
    
    var body: some View {
        ZStack {
            
            if !editMode {
                DetailCardView(item: item)
                Spacer()
                    .frame(minHeight: 200, maxHeight: 400, alignment: .bottom)
                
                
                
                    .toolbar {
                        // Item
                        // Share
                        ToolbarItem{
                            ShareLink(item: item.title!, subject: Text("Rappel"), message: Text("\(item.content!) le: \(item.lastTime!, formatter: itemFormatter)")) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        // Edit
                        ToolbarItem (placement: .navigationBarTrailing) {
                            Button {
                                //
                                editMode.toggle()
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        // Title
                        ToolbarItem(placement: .principal) {
                            Text(item.title!)
                                .fontWeight(.semibold)
                        }
                    }
            } else {
                // If editMode = Updatable View
                VStack {
                    Form{
                        Section {
                            TextField(item.title!, text: Binding($item.title)!)
                            TextField(item.content!, text: Binding($item.content)!, axis: .vertical)
                        }header: {
                            Text("Informations")
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
                            DatePicker("Date :", selection: Binding($item.lastTime)!, displayedComponents: .date)
                            DatePicker("Heure :", selection: Binding($item.lastTime)!, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                Button {
                    item.category = categorySelection
                    coreDM.updateItem()
                    editMode.toggle()
                } label: {
                    Text("Valider")
                }
            }
            // Slider
            VStack {
                Spacer()
                    .frame(height: 600)
                TriggerSliderView(simpleRightDirectionSliderOffsetX: $simpleRightDirectionSliderOffsetX, alertPresented: $alertPresented)
                    .alert("Important message", isPresented: $alertPresented) {
                        Button {
                            item.done = true
                            coreDM.updateItem()
                            needsRefresh.toggle()
                            //                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(1)) {
                            self.presentationMode.wrappedValue.dismiss()
                            //                            }
                        } label: {
                            Text("Valider")
                        }
                        Button("Annuler", role: .cancel) {
                            withAnimation {
                                self.simpleRightDirectionSliderOffsetX = 0
                            }
                        }
                    }
            }
        }
    }
    
}


/*/
 struct TaskDetailView_Previews: PreviewProvider {
 static var previews: some View {
 TaskDetailView(coreDM: CoreDataManager(), item: Item(), needsRefresh: .constant(false))
 }
 }
 */
