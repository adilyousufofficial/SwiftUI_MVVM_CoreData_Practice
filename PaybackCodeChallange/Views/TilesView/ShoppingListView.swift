//
//  ShoppingListView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 26/08/2022.
//

import SwiftUI
import Foundation
import UIKit

struct ShoppingListView: View {
    @State var fullPageHeight: Bool
    @StateObject private var shoppingListViewModel = ShoppingListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter new task", text: $shoppingListViewModel.title)
                    .onChange(of: shoppingListViewModel.title) {
                        print($0)
                    }
                    .disableAutocorrection(true)
                Divider()
                Button(action: addItemClicked, label: {
                    Text("Add")
                        .foregroundColor(.accentColor)
                })
            }
            .frame(height: 25, alignment: .topLeading)
            .padding([.leading,.trailing],20)
            List {
                ForEach (shoppingListViewModel.tasks, id: \.id) { task in
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .red)
                            Text(task.title)
                                .padding(.leading,5)
                                .padding(.trailing,5)
                                .lineLimit(1)
                        }
                        .onTapGesture {
                            withAnimation(.linear) {
                                do {
                                    try shoppingListViewModel.update(task)
                                    shoppingListViewModel.getAllTasks()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
                .onDelete(perform: deleteTask)
                .onAppear(perform: {
                    shoppingListViewModel.getAllTasks()
                })
            }
            .listStyle(.plain)
            .frame(width: UIScreen.main.bounds.width, height: fullPageHeight ? UIScreen.main.bounds.height-250 : shoppingListViewModel.tasks.count * 40 < 250 ? CGFloat(shoppingListViewModel.tasks.count * 40) : 250, alignment: .topLeading)
            .listRowSeparator(.hidden)
            .navigationBarItems(leading: EditButton())
        }
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
    
    func addItemClicked() {
        if textIsAppropriate() {
            shoppingListViewModel.save()
            shoppingListViewModel.getAllTasks()
            shoppingListViewModel.title = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = shoppingListViewModel.tasks[index]
            shoppingListViewModel.delete(task)
        }
        
        shoppingListViewModel.getAllTasks()
    }
    
    func textIsAppropriate() -> Bool {
        if shoppingListViewModel.title.count < 3 {
            return false
        }
        return true
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let persistedContainer = CoreDataManager.shared.persistentContainer
            ShoppingListView(fullPageHeight: true).environment(\.managedObjectContext, persistedContainer.viewContext)
        }
    }
}
