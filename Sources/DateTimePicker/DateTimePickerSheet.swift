//
//  DateTimePickerSheet.swift
//  DateTimePicker
//
//  Created by Dileep Kumar on 31/10/25.
//

import SwiftUI

public struct DateTimePickerSheet: View {
    
    public enum PickerMode {
        case date, time, dateAndTime
        
        var components: DatePickerComponents {
            switch self {
            case .date: return .date
            case .time: return .hourAndMinute
            case .dateAndTime: return [.date, .hourAndMinute]
            }
        }
    }
    
    @Binding var isPresented: Bool
    @State private var selectedDate: Date
    private let title: String
    private let mode: PickerMode
    private let onConfirm: (Date) -> Void
    private let onCancel: (() -> Void)?
    
    public init(
        isPresented: Binding<Bool>,
        title: String = "Select Date & Time",
        mode: PickerMode = .date,
        initialDate: Date? = nil,
        onConfirm: @escaping (Date) -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._selectedDate = State(initialValue: initialDate ?? Date())
        self.title = title
        self.mode = mode
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }
    
    public var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        onCancel?()
                        withAnimation { isPresented = false }
                    }
                
                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)
                        .padding(.top, 16)
                    
                    Divider()
                    
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: mode.components
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    
                    Divider()
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            onCancel?()
                            withAnimation { isPresented = false }
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        
                        Divider()
                            .frame(height: 50)
                        
                        Button(action: {
                            onConfirm(selectedDate)
                            withAnimation { isPresented = false }
                        }) {
                            Text("Confirm")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.purple)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .frame(height: 50)
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                //.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
            }
            .transition(.opacity.combined(with: .move(edge: .bottom)))
            .animation(.easeInOut, value: isPresented)
        }
    }
}

public extension DateTimePickerSheet {
    
    static func showDatePicker(
        isPresented: Binding<Bool>,
        title: String = "Select Date",
        initialDate: Date? = nil,
        onConfirm: @escaping (Date) -> Void,
        onCancel: (() -> Void)? = nil
    ) -> DateTimePickerSheet {
        DateTimePickerSheet(
            isPresented: isPresented,
            title: title,
            mode: .date,
            initialDate: initialDate,
            onConfirm: onConfirm,
            onCancel: onCancel
        )
    }
    
    static func showTimePicker(
        isPresented: Binding<Bool>,
        title: String = "Select Time",
        initialDate: Date? = nil,
        onConfirm: @escaping (Date) -> Void,
        onCancel: (() -> Void)? = nil
    ) -> DateTimePickerSheet {
        DateTimePickerSheet(
            isPresented: isPresented,
            title: title,
            mode: .time,
            initialDate: initialDate,
            onConfirm: onConfirm,
            onCancel: onCancel
        )
    }
    
    static func showDateTimePicker(
        isPresented: Binding<Bool>,
        title: String = "Select Date & Time",
        initialDate: Date? = nil,
        onConfirm: @escaping (Date) -> Void,
        onCancel: (() -> Void)? = nil
    ) -> DateTimePickerSheet {
        DateTimePickerSheet(
            isPresented: isPresented,
            title: title,
            mode: .dateAndTime,
            initialDate: initialDate,
            onConfirm: onConfirm,
            onCancel: onCancel
        )
    }
}
