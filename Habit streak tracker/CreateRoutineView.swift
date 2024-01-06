//
//  CreateRoutineView.swift
//  Habit streak tracker
//
//  Created by Kirills Galenko on 06/01/2024.
//

import SwiftUI

struct CreateRoutineView: View {
    @State private var routineTitle: String = ""
    @State private var routineDescription: String = ""
    @State private var date = Date()
    @State private var isDatePickerVisible = false

    var body: some View {
        Form {
            Section(header: Text("Routine Information")) {
                TextField("Routine title", text: $routineTitle)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $routineDescription)
                        .frame(height: 100)
                    
                    if routineDescription.isEmpty {
                        Text("Description")
                            .foregroundColor(.gray)
                            .padding(4)
                    }
                }

                Button(action: {
                    isDatePickerVisible.toggle()
                }) {
                    HStack {
                        Text("Starting on:")
                        Spacer()
                        Text("\(formattedDate)")
                            .foregroundColor(.blue)
                    }
                }

                if isDatePickerVisible {
                    DatePicker(
                        "Start Date",
                        selection: $date,
                        in: Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                }
            }

            Section {
                Button(action: {
                    // Add your logic for creating the routine here
                    print("Create routine button tapped!")
                }) {
                    Text("Create Routine")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
    }

    private var formattedDate: String {
        let now = Date()
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if let days = Calendar.current.dateComponents([.day], from: now, to: date).day, days <= 7 {
            return formatter.localizedString(for: date, relativeTo: now)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
    }
}

struct CreateRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutineView()
    }
}
