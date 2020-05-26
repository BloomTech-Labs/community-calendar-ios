//
//  EventVC+CollectionView.swift
//  Community Calendar
//
//  Created by Michael on 5/8/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import JTAppleCalendar

extension EventViewController: JTACMonthViewDataSource, JTACMonthViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        handleCellSelected(cell: cell, cellState: cellState)
        let dateString = dateFormatter.string(from: date)
        let formattedDate = dateFormatter.date(from: dateString)
        self.dateSelected = formattedDate
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        handleCellSelected(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        configureCell(cell: cell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as? DateCell else { return JTACDayCell() }

        configureCell(cell: cell, cellState: cellState)

        return cell

    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = jtCalCompareFormatter.date(from: "01-jan-2019")!
        let endDate = jtCalCompareFormatter.date(from: "17-may-2027")!

        let config = ConfigurationParameters.init(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: .autoupdatingCurrent, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
        return config
    }
    
    func configureCell(cell: DateCell, cellState: CellState) {
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.1722870469, green: 0.1891334951, blue: 0.2275838256, alpha: 1)
        cell.selectedView.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        
        if cell.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
        cell.dateLabel.text = cellState.text

        handleCellEvents(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .black
            cell.dateLabel.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 12)
        } else {
            cell.dateLabel.textColor = .lightGray
            cell.dateLabel.font = UIFont(name: PoppinsFont.light.rawValue, size: 12)
        } 
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.isHidden = false
            cell.dateLabel.textColor = .white
            cell.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.selectedView.isHidden = true
            cell.dateLabel.textColor = .black
            cell.layer.borderColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        }
    }
    
    func handleCellEvents(cell: DateCell, cellState: CellState) {
        let dateString = jtCalCompareFormatter.string(from: cellState.date)
        if createdCalDataSource[dateString] == nil {
            cell.createdDot.isHidden = true
        } else {
            cell.createdDot.isHidden = false
        }

        if savedCalDataSource[dateString] == nil {
            cell.savedDot.isHidden = true
        } else {
            cell.savedDot.isHidden = false
        }

        if attendingCalDataSource[dateString] == nil {
            cell.attendingDot.isHidden = true
        } else {
            cell.attendingDot.isHidden = false
        }
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendarView.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = jtCalMonthFormatter.string(from: range.start)
        return header
    }
    
    internal func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
    func sortEvents() {
        var attendingEvents: [Event] = []
        var savedEvents: [Event] = []
        var createdEvents: [Event] = []
        for event in events {
            if event.eventType == .attending {
                let createdEvent = event
                attendingEvents.append(createdEvent)
            } else if event.eventType == .saved {
                let savedEvent = event
                savedEvents.append(savedEvent)
            } else if event.eventType == .created {
                let createdEvent = event
                createdEvents.append(createdEvent)
            }
        }
        self.attendingEvents = attendingEvents
        self.savedEvents = savedEvents
        self.createdEvents = createdEvents
    }
    
    func populateDataSource() {
        
        if currentUser == nil || authController?.stateManager?.accessToken == nil {
            createdCalDataSource.removeAll()
            savedCalDataSource.removeAll()
            attendingCalDataSource.removeAll()
        }
        
        guard
            let createdEvents = self.createdEvents,
            let savedEvents = self.savedEvents,
            let attendingEvents = self.attendingEvents
            else { return }
    
        for event in createdEvents {
            if let date = event.startDate {
                let eventDate = jtCalCompareFormatter.string(from: date)
                createdCalDataSource[eventDate] = eventDate
            }
        }
        
        for event in savedEvents {
            if let date = event.startDate {
                let eventDate = jtCalCompareFormatter.string(from: date)
                savedCalDataSource[eventDate] = eventDate
            }
        }
        
        for event in attendingEvents {
            if let date = event.startDate {
                let eventDate = jtCalCompareFormatter.string(from: date)
                attendingCalDataSource[eventDate] = eventDate
            }
        }
        calendarView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myEventsCollectionView {
            return filteredEvents.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
            
            let event = filteredEvents[indexPath.item]
            cell.event = event

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myEventsCollectionView {
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myEventsCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: myEventsCollectionView.bounds.height / 4)
        }
        return CGSize()
    }
}
