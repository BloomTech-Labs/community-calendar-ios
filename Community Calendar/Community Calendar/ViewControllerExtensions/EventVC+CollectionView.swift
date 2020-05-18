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
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let dateCell = cell as! DateCell
        configureCell(view: dateCell, cellState: cellState)

    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        
        configureCell(view: cell, cellState: cellState)
        
        return cell

    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = jtCalCompareFormatter.date(from: "17-may-2020")!
        let endDate = jtCalCompareFormatter.date(from: "17-may-2025")!

        let config = ConfigurationParameters.init(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: .autoupdatingCurrent, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
        return config
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        let cell = view as! DateCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.1722870469, green: 0.1891334951, blue: 0.2275838256, alpha: 1)
        cell.dateLabel.text = cellState.text
        handleCellEvents(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .followingMonthWithinBoundary {
            cell.dateLabel.textColor = .gray
            cell.dateLabel.font = UIFont(name: PoppinsFont.light.rawValue, size: 12)
        } else if cellState.dateBelongsTo == .previousMonthWithinBoundary {
            cell.dateLabel.textColor = .gray
            cell.dateLabel.font = UIFont(name: PoppinsFont.light.rawValue, size: 12)
        } else if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .black
            cell.dateLabel.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 12)
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = #colorLiteral(red: 1, green: 0.3987820148, blue: 0.4111615121, alpha: 1)
        } else {
            cell.selectedView.isHidden = true
            cell.selectedView.backgroundColor = .white
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

    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        let dateCell = cell as! DateCell
        configureCell(view: cell, cellState: cellState)
        handleCellSelected(cell: dateCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        let dateCell = cell as! DateCell
        configureCell(view: cell, cellState: cellState)
        handleCellSelected(cell: dateCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendarView.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = jtCalMonthFormatter.string(from: range.start)
        return header
    }
    
    internal func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
    func populateDataSource() {
        guard
            let createdEvents = self.createdEvents,
            let savedEvents = self.savedEvents,
            let attendingEvents = self.attendingEvents
            else { return }
        
        for event in createdEvents {
            let eventDate = jtCalCompareFormatter.string(from: event.startDate)
            createdCalDataSource[eventDate] = eventDate
        }
        
        for event in savedEvents {
            let eventDate = jtCalCompareFormatter.string(from: event.startDate)
            savedCalDataSource[eventDate] = eventDate
        }
        
        for event in attendingEvents {
            let eventDate = jtCalCompareFormatter.string(from: event.startDate)
            attendingCalDataSource[eventDate] = eventDate
        }
        
        print("This is the calendar data source: \(createdCalDataSource)")
        calendarView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myEventsCollectionView {
            switch userEvents {
            case .created:
                return createdEvents?.count ?? 0
            case .saved:
                return savedEvents?.count ?? 0
            case .attending:
                return attendingEvents?.count ?? 0
            case .none:
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }

            if userEvents == .created {
                let event = createdEvents?[indexPath.item]
                cell.createdEvent = event
            } else if userEvents == .saved {
                let event = savedEvents?[indexPath.item]
                cell.savedEvent = event
            } else if userEvents == .attending {
                let event = attendingEvents?[indexPath.item]
                cell.attendingEvent = event
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myEventsCollectionView {
//            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
//            self.featuredIndexPath = indexPath
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myEventsCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9)
        }
        return CGSize()
    }
    
    func getUsersEvents(completion: @escaping (Swift.Result<FetchUserIdQuery.Data.User, Error>) -> Void) {
        if let oktaID = authController?.oktaID {
            Apollo.shared.fetchUserID(oktaID: oktaID) { result in
                if let user = try? result.get(), let createdEvents = user.createdEvents, let savedEvents = user.saved, let attendingEvents = user.rsvps {
                    let sortedCreated = createdEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedSaved = savedEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedAttending = attendingEvents.sorted(by: { $0.startDate < $1.startDate })
                    self.currentUser = user
                    self.createdEvents = sortedCreated
                    self.savedEvents = sortedSaved
                    self.attendingEvents = sortedAttending
                    print("Created Events: \(String(describing: self.createdEvents?.count)), Saved Events: \(String(describing: self.savedEvents?.count)), Attending Events: \(String(describing: self.attendingEvents?.count))")
                    completion(.success(user))
                }
            }
        }
    }
}
