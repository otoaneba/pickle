//
//  CustomCalendarView.swift
//  pickle
//
//  Created by Naoto Abe on 11/11/23.
//

import HorizonCalendar
import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeCalendar()
    }
    
    private func makeCalendar() {
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2023, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: .now), month: calendar.component(.month, from: .now), day: calendar.component(.day, from:.now)))!
        
        let calendarViewContent = CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        let calendarView = CalendarView(initialContent: calendarViewContent)
        
        view.addSubview(calendarView)

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
