//
//  AddTodoView.swift
//  HoneyDo
//
//  Created by Adam Lea on 6/7/20.
//  Copyright © 2020 Adam Lea. All rights reserved.
//

import SwiftUI

struct AddTodoView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @State private var name: String = ""
  @State private var priority: String = "Normal"
  
  // MARK: - Error Handling
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let priorities = ["High", "Normal", "Low"]
    
  // MARK: - BODY
  
  var body: some View {
    NavigationView {
        VStack {
          Form {
            // MARK: - TODO NAME
            TextField("Todo", text: $name)
              
            // MARK: - TODO PRIORITY
            Picker("Priority", selection: $priority) {
              ForEach(priorities, id: \.self) {
                Text($0)
              }
            }//: PICKER
            .pickerStyle(SegmentedPickerStyle())
              
            // MARK: - SAVE BUTTON
            Button(action: {
              if (self.name) != "" {
                let todo = Todo(context: self.managedObjectContext)
                todo.name = self.name
                todo.priority = self.priority
                
                do {
                  try self.managedObjectContext.save()
                  print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                } catch {
                  print(error)
                }
              } else {
                self.errorShowing = true
                self.errorTitle = "Invalid Name"
                self.errorMessage = "Make sure to enter a name for\n the new todo item"
                return
              }
              self.presentationMode.wrappedValue.dismiss()
              }) {
              Text("Save")
            }//: BUTTON
              
          }//: FORM
          Spacer()
        }//: VSTACK
          .navigationBarTitle("New Todo", displayMode: .inline)
      .navigationBarItems(trailing:
        Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "xmark")
        }
      )
          .alert(isPresented: $errorShowing){
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW

struct AddTodoView_Previews: PreviewProvider {
  static var previews: some View {
      AddTodoView()
  }
}
