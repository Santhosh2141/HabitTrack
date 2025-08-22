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
}

class Habits: ObservableObject{
    @Published var habits = [HabitItem]()
    
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
                        HStack{
                            Text(habit.name)
                            Spacer()
                            Text(habit.habitCount, format: .number)
                        }
                        .padding(.vertical, 5)
                    }
                }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
