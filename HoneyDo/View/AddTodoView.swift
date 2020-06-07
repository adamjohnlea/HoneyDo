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
  
  @State private var name: String = ""
  @State private var priority: String = "Normal"
  
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
            Button(action: {print("Save a new Todo item")}) {
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
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW

struct AddTodoView_Previews: PreviewProvider {
  static var previews: some View {
      AddTodoView()
  }
}
