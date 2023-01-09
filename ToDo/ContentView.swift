//
//  ContentView.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 05/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    let notificationManager: NotificationManager
    
    @State private var items: [Item] = [Item]()
    @State private var needsRefresh: Bool = false
    
    /* @State */
    @State private var doneFilter = false
    @State private var newTask = false
    @State private var pickerSelection = 0
    
    func populateItems() {
        items = coreDM.getAllItems()
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    Picker("", selection: $pickerSelection) {
                        Text("To Do").tag(0)
//                            .onAppear {
//                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(1)) {
//                                    items = coreDM.getAllItems()
//                                }
//                            }
                        Text("Done").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .colorMultiply(.indigo)
                    List {
                        ForEach(items, id: \.self) { item in
                            if !item.done && pickerSelection == 0 {
                                NavigationLink {
                                    TaskDetailView(coreDM: coreDM, item: item, needsRefresh: $needsRefresh)
                                } label: {
                                    cardView(title: item.title!, content: item.content!, date: item.lastTime!, done: item.done)
                                        .listRowSeparator(.hidden)
                                        .padding(.vertical, -12)
                                        .padding(.leading, -20)
                                        .padding(.trailing, -39)
                                        .onAppear {
                                            scheduleNotification(triggerDate: item.lastTime!, itemContent: "\(item.title!):\n \(item.content!) \n \(item.lastTime!)")
//                                            item.done = needsRefresh
//                                            populateItems()
//                                            needsRefresh = false
                                        }
                                }
                            } else if item.done && pickerSelection == 1  {
                                cardView(title: item.title!, content: item.content!, date: item.lastTime!, done: item.done)
                                    .listRowSeparator(.hidden)
                                    .padding(-20)
                            }
                        }// FIN FOREACH
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let item = items[index]
                                // delete it using Core Data Manager
                                coreDM.deleteItem(item: item)
                                
                            }
                        })
                        .onMove(perform: onMove)
                    }
                    .scrollContentBackground(.hidden)
                    //                .listStyle(.inset)
                    //                .listRowSeparator(.hidden)
                    
                }
                .background(
                    Image("back")
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .ignoresSafeArea()
                )
                .onAppear(perform: {
                    populateItems()
                })
                .sheet(isPresented: $newTask) {
                    AddTaskView(coreDM: coreDM, items: $items, addTask: $newTask)
                        .presentationDetents([.medium,.large])
                }
                .toolbar {
                    //                if !doneFilter {
                    //                    ToolbarItem(placement: .navigationBarTrailing) {
                    //                        EditButton()
                    //                    }
                    //                }
                    ToolbarItem(placement: .principal) {
                        Text("To Do App")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        newTask = true
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(.indigo)
                                .shadow(color: .black, radius: 5, x: 5, y: 5)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                        }
                        .padding()
                        
                    }
                }
            }
        }
    }
    func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func scheduleNotification(triggerDate: Date, itemContent: String) {
        let notificationId = UUID()
        let content = UNMutableNotificationContent()
        content.body = "Nouvelle notification \(itemContent)"
        content.sound = UNNotificationSound.default
        content.userInfo = [
            "notificationId": "\(notificationId)" // additional info to parse if need
        ]
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: NotificationHelper.getTriggerDate(triggerDate: triggerDate)!,
            repeats: false
        )
        
        notificationManager.scheduleNotification(
            id: "\(notificationId)",
            content: content,
            trigger: trigger)
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    
    return formatter
}()


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager(), notificationManager: NotificationManager())
    }
}
