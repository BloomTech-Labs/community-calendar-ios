//
//  EventVC+JTCalendarDelegate.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit


//extension EventViewController: JTACMonthViewDelegate {
//    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
//        let cell = cell as! DateCollectionViewCell
//        cell.dateLabel.text = cellState.text
//        if cellState.dateBelongsTo != .thisMonth {
//            cell.dateLabel.text = ""
//        } else {
//            
//        }
//        
//    }
//    
//    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
//        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as? DateCollectionViewCell else { return JTACDayCell() }
//        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
//        cell.dateLabel.text = cellState.text
//        cell.dateLabel.textColor = UIColor.black
//        if cellState.dateBelongsTo != .thisMonth {
//            cell.dateLabel.text = ""
//        } else {
//           
//        }
//        cell.layer.borderWidth = 1.0
//        cell.layer.borderColor = UIColor.black.cgColor
////        cell.layer.cornerRadius = 8.0
//        
//        return cell
//    }
//    
//    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
//        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
//        formatter.dateFormat = "MMM"
//        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeaderView
//        
//        header.monthLabel.text = formatter.string(from: range.start)
////        header.layer.cornerRadius = 8.0
//        header.layer.borderColor = UIColor.black.cgColor
//        header.layer.borderWidth = 1.0
//        return header
//    }
//    
//    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
//        return MonthSize(defaultSize: 75)
//    }
//}
