//
//  TableViewUpdater.swift
//  Dwifft
//
//  Created by Sid on 07/03/2017.
//  Copyright © 2017 jflinter. All rights reserved.
//

import UIKit

public class TableViewUpdater: DiffableViewUpdater {
    weak var tableView: UITableView?

    private let insertionAnimation: UITableView.RowAnimation
    private let deletionAnimation: UITableView.RowAnimation

    public init(tableView: UITableView,
                insertionAnimation: UITableView.RowAnimation = .automatic,
                deletionAnimation: UITableView.RowAnimation = .automatic) {
        self.tableView = tableView
        self.insertionAnimation = insertionAnimation
        self.deletionAnimation = deletionAnimation
    }

    public func perform(operations: ViewOperationsType, animated: Bool, completion: @escaping () -> Void) {
        
        guard animated else {
            completion()
            tableView?.reloadData()
            return
        }

        tableView?.beginUpdates()
        tableView?.deleteRows(at: operations.deletionIndexPaths, with: deletionAnimation)
        tableView?.insertRows(at: operations.insertionIndexPaths, with: insertionAnimation)
        completion()
        tableView?.endUpdates()
    }
}

