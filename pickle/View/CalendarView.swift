//
//  CalendarView.swift
//  pickle
//
//  Created by Naoto Abe on 11/11/23.
//

import SwiftUI

struct MyCalendarView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarViewController = CalendarViewController()
        return calendarViewController
    }
    
    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {}
    
    typealias UIViewControllerType = CalendarViewController
}

#Preview {
    MyCalendarView()
}
