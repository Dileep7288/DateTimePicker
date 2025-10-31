# DateTimePicker

A SwiftUI package to show customizable date, time, and date-time pickers with a bottom sheet style.

## Features
- Show date picker, time picker, or both.
- Customizable title.
- Supports iOS 15+.
- Easy integration as a Swift Package.

## Installation

### Swift Package Manager
You can add this package via Xcode:
1. File → Add Packages → Enter GitHub URL: `https://github.com/<your-username>/DateTimePicker.git`
2. Select the package and add it to your project.

## Usage

```swift
import SwiftUI
import DateTimePicker

struct ContentView: View {
    @State private var showPicker = false
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Button("Show Date Picker") {
                showPicker = true
            }
        }
        .overlay(
            DateTimePickerSheet.showDatePicker(
                isPresented: $showPicker,
                initialDate: selectedDate,
                onConfirm: { date in
                    selectedDate = date
                }
            )
        )
    }
}
