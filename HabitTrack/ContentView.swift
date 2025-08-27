//
//  ContentView.swift
//  HabitTrack
//
//  Created by Santhosh Srinivas on 22/08/25.
//

import SwiftUI

struct HabitItem: Identifiable, Codable, Hashable, Equatable{
    
    var id = UUID()
    let name: String
    let description: String
    var habitCount: Int
    var completedDate: String
    
//    mutating func modifyDate(date: String){
//        completedDate.append(date)
//    }
}

class Habits: ObservableObject{
    @Published var habits = [HabitItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(habits){
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
            
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits"){
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: savedHabits){
                habits = decoded
                return
            }
        }
        habits = []
    }
    
}

struct ContentView: View {
    
    @ObservedObject var habits = Habits()
    @State private var sheetToggle = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(habits.habits, id: \.id){ habit in
                    NavigationLink{
                        DescriptionView(habit: habit, habits: habits)
                    }label: {
                        VStack(alignment: .leading){
                            HStack{
                                Text(habit.name)
                                Spacer()
                                Text(habit.completedDate)
                            }
                            Spacer()
                            HStack{
                                Text("Times Habit completed: ")
                                Spacer()
                                Text(habit.habitCount, format: .number)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habit Track")
            .toolbar{
                Button{
                    sheetToggle.toggle()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add a Habit")
                    }
                }
            }
            .sheet(isPresented: $sheetToggle){
                AddHabitView(habit: habits)
            }
        }
    }
    
    func removeHabit(at offsets: IndexSet){
        
        habits.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
