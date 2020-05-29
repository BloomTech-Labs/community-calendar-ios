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
    
    func removeDuplicates(array: [Event], completion: @escaping ([Event]) -> Void)  {
        var set = Set<Event>()
        var result: [Event] = []
        for event in array {
            if set.contains(event) {
                
            } else {
                set.insert(event)
                result.append(event)
            }
        }
        completion(result)
    }
    
    func setupSubViews() {
        let insetWidth = UIScreen.main.bounds.width - 40
        let width = UIScreen.main.bounds.width
        let calendarViewHeight = UIScreen.main.bounds.height * 0.35
        
        calendarBackgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 8, left: 0, bottom: -8, right: 0), size: .init(width: insetWidth, height: calendarViewHeight))
        
        calendarView.anchor(top: calendarBackgroundView.topAnchor, leading: calendarBackgroundView.leadingAnchor, trailing: calendarBackgroundView.trailingAnchor, bottom: calendarBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        filterView.anchor(top: calendarBackgroundView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .zero, size: .init(width: width, height: 40))
        
        filterButtonStackView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: filterView.centerXAnchor, centerY: filterView.centerYAnchor)
        
        myEventsCollectionView.anchor(top: filterView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
    }
    
    func configureViews() {
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        calendarView.layer.borderColor = #colorLiteral(red: 0.1722870469, green: 0.1891334951, blue: 0.2275838256, alpha: 1)
        calendarView.backgroundColor = .white
        calendarView.layer.borderWidth = 1.0
        calendarView.layer.masksToBounds = true
        calendarView.layer.masksToBounds = true
        calendarBackgroundView.layer.cornerRadius = calendarBackgroundView.bounds.height * 0.04
        calendarView.layer.cornerRadius = calendarBackgroundView.bounds.height * 0.04
        
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.allowsRangedSelection = true
        createdButtonTapped(UIButton())
        calendarBackgroundView.calendarShadow()
    }
    
    func filterAttendingEvents() {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .attending
        filteredEvents = events.filter({ $0.eventType == .attending })
        filteredEvents.sort(by: { $0.startDate < $1.startDate })
        attendingEventsIndicator.alpha = 1
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    func filterSavedEvents() {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .saved
        filteredEvents = events.filter({ $0.eventType == .saved })
        filteredEvents.sort(by: { $0.startDate < $1.startDate })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 1
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    func filterCreatedEvents() {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        userEvents = .created
        filteredEvents = events.filter({ $0.eventType == .created })
        filteredEvents.sort(by: { $0.startDate < $1.startDate })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 1
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    @objc func dateTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        if let date = self.dateSelected {
            let range = apolloController?.selectedDate(date: date)
            filteredEvents = []
            if let start = range?.first, let end = range?.last {
                let selectedEvents = events.filter({ ($0.startDate.isBetween(start, and: end))})
                removeDuplicates(array: selectedEvents) { reducedEvents in
                    self.filteredEvents = reducedEvents
                    if self.filteredEvents.count < 1 {
                        let prettyDate = featuredEventDateFormatter.string(from: date)
                        self.noEventsLabel.text = "You have no events on \(prettyDate)."
                        self.noEventsLabel.isHidden = false
                    } else {
                        self.noEventsLabel.isHidden = true
                    }
                    
                    self.myEventsCollectionView.reloadData()
                }
                
            }
        }
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 0.5
    }
    
    func checkCurrentuser() {
        if let user = apolloController?.currentUser, let userEvents = user.userEvents {
            if self.events.count != userEvents.count {
                self.events = userEvents
                self.noEventsLabel.isHidden = true
                self.noEventsLabel.text = ""
                myEventsCollectionView.reloadData()
            } else {
                if let oktaID = apolloController?.defaults.string(forKey: UserDefaults.Keys.oktaID.rawValue) {
                    apolloController?.fetchUserID(oktaID: oktaID, completion: { _ in
                        guard let userEvents = self.apolloController?.currentUser?.userEvents else { return }
                        self.events = userEvents
                    })
                }
            }
        } else if apolloController?.currentUser == nil || authController?.stateManager?.accessToken == nil {
            self.noEventsLabel.isHidden = false
            self.noEventsLabel.text = "Please sign in to view your events..."
            self.events.removeAll()
            self.filteredEvents.removeAll()
            self.attendingEvents = nil
            self.savedEvents = nil
            self.createdEvents = nil
            calendarView.reloadData()
            myEventsCollectionView.reloadData()
        }
    }
    
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 14) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
}
