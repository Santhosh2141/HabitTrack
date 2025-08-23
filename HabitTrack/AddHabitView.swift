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
    @State private var completedDate = ""
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
                        getDate()
                        var newHabit = HabitItem(name: name, description: desc, habitCount: 1, completedDate: completedDate)
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
    
    func getDate(){
        let currentDate = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        let date = dateFormatter.string(from: currentDate)
        completedDate = date
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habit: Habits())
    }
}
