//
//  AddHabitView.swift
//  HabitTrack
//
//  Created by Santhosh Srinivas on 22/08/25.
//

import SwiftUI

struct AddHabitView: View {
    
    @State private var name = ""
    @State private var desc = ""
    @State private var habitCount = 0
    var habit: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    TextField("Enter a new Habit", text: $name)
                    TextField("Enter the description", text: $desc)
                }
                .navigationTitle("New Habit")
                .toolbar{
                    Button{
                        var newHabit = HabitItem(name: name, description: desc, habitCount: 1)
                        if (!newHabit.name.isEmpty){
                            habit.habits.append(newHabit)
                        }
                        
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    
                }
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habit: Habits())
    }
}
