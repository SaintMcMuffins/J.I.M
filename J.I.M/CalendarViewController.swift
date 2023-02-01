//
//  CalendarViewController.swift
//  J.I.M
//
//  Created by Julian Manaois on 1/31/23.
//

import Foundation
import UIKit
import CoreData
import User

class CalendarViewController: UIViewController {
    private let calendar = Calendar.current
    private var currentMonthDate: Date!
    private var selectedDate: Date!
    private let cellReuseIdentifier = "calendarCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayActivitiesView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentMonthDate = Date()
        selectedDate = Date()

        collectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)

        updateMonthLabel()

        dayActivitiesView.isHidden = true
    }

    private func updateMonthLabel() {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM yyyy"
        monthLabel.text = monthFormatter.string(from: currentMonthDate)
    }

    @IBAction func previousMonth(_ sender: Any) {
        currentMonthDate = calendar.date(byAdding: .month, value: -1, to: currentMonthDate)!
        collectionView.reloadData()
        updateMonthLabel()
    }

    @IBAction func nextMonth(_ sender: Any) {
        currentMonthDate = calendar.date(byAdding: .month, value: 1, to: currentMonthDate)!
        collectionView.reloadData()
        updateMonthLabel()
    }

    @IBAction func todayButton(_ sender: Any) {
        currentMonthDate = Date()
        collectionView.reloadData()
        updateMonthLabel()
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let range = calendar.range(of: .day, in: .month, for: currentMonthDate)!
        return range.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CalendarCell

        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonthDate))!
        let date = calendar.date(byAdding: .day, value: indexPath.item, to: startOfMonth)!

        cell.dateLabel.text = String(calendar.component(.day, from: date))

        if calendar.isDateInToday(date) {
            cell.dateLabel.textColor = .red
        } else {
            cell.dateLabel.textColor = .black
        }

        if date == selectedDate {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }

        return cell
    }
}

extension CalendarViewController: UICollection {
    
    private func getLoggedInUser() -> User? {
        let request = User.fetchRequest() as NSFetchRequest<User>
        request.predicate = NSPredicate(format: "isLoggedIn == true")
        do {
            let users = try PersistenceService.context.fetch(request)
            if let user = users.first {
                return user
            }
        } catch {
            print("Error fetching logged in user: \(error)")
        }
        return nil
    }
}

