//
//  FSCalendar+Extension.swift
//  Itechnolabs
//
//  Created by Jatin on 18/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import FSCalendar

extension FSCalendar {
    func setupCalendar() {
        self.appearance.headerTitleFont = AppFont.bold.fontWithSize(18)
        self.appearance.headerTitleColor = UIColor.appBlack
        
        self.appearance.weekdayFont = AppFont.bold.fontWithSize(12)
        self.appearance.weekdayTextColor = UIColor.coolGrey
        
//        self.appearance.titleFont = AppFont.regular.fontWithSize(14)
//        self.appearance.titleDefaultColor = UIColor.coolGrey
//        
        self.appearance.selectionColor = UIColor.appOrange
        self.appearance.todayColor = UIColor.lightLavendar
        
//        self.scrollDirection = .vertical
//        self.pagingEnabled = false
        
        self.appearance.headerSeparatorColor = .clear
        
//        self.allowsSelection = false
    }
    
    func showNextMonth() {
        self.setCurrentPage(self.getNextMonth(date: self.currentPage), animated: true)
    }

    func showPreviousMonth() {
        self.setCurrentPage(getPreviousMonth(date: self.currentPage), animated: true)
    }
    
    private func getNextMonth(date:Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    private func getPreviousMonth(date:Date) -> Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
     }
}
