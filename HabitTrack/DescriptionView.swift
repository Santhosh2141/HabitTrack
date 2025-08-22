//
//  DescriptionView.swift
//  HabitTrack
//
//  Created by Santhosh Srinivas on 22/08/25.
//

import SwiftUI

struct DescriptionView: View {
    
    var habit: HabitItem
    @StateObject var habits: Habits
    var body: some View {
        VStack{
            Text(habit.description)
            Button{
                if let index = habits.habits.firstIndex(of: habit) {
                    habits.habits[index].habitCount += 1
                }
            } label: {
                Text("Increment Habit Count")
            }
//            Text(habit.habitCount)
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(habit: HabitItem(name: "trial", description: "trial", habitCount: 1), habits: Habits())
    }
}
