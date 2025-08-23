//
//  DescriptionView.swift
//  HabitTrack
//
//  Created by Santhosh Srinivas on 22/08/25.
//

import SwiftUI

struct DescriptionView: View {
    
    var habit: HabitItem
    @ObservedObject var habits: Habits
    @State private var completedDate = ""
    @State private var showAlert = false
    var body: some View {
        VStack{
            Text(habit.description)
            Button{
                showAlert = true
            } label: {
                Text("Complete Habit")
                    .font(.title)
                    .padding()
                    .background(.cyan)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
            }
            .alert("Complete the Habit?", isPresented: $showAlert){
                Button{
                    
                } label: {
                    Text("No")
                        .foregroundColor(Color.red)
                }
                Button{
                    getDate()
                    if let index = habits.habits.firstIndex(of: habit) {
                        habits.habits[index].habitCount += 1
                        habits.habits[index].completedDate = completedDate
                    }
                } label: {
                    Text("Yes")
                        .bold()
                }
            } message: {
                Text("Has this habit been completed successfully?")
            }

//            Text(habit.habitCount)
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

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(habit: HabitItem(name: "trial", description: "trial", habitCount: 1, completedDate: "trial date"), habits: Habits())
    }
}
