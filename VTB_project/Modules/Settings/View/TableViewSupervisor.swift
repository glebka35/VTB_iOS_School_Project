//
//  TableViewSupervisor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class TableViewSupervisor: NSObject {
//    MARK: - Properties

    private var tableView: UITableView
    private var cellModels: [[CellViewModel]] = []

    weak var delegate: DetailTableSupervisorDelegate?

//    MARK: - Life cycle

    override init() {
        tableView = UITableView()
    }

//    MARK: - UI configuration

    func getConfiguredTableView()->UITableView {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }

//    MARK: - UI update

    func update(with data: [[CellViewModel]]) {
        self.cellModels = data
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate

extension TableViewSupervisor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.languageChosen(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension TableViewSupervisor: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cellModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return TableViewCell() }

        let isDestructive = indexPath.section == cellModels.count - 1
        let isFirst = indexPath.row == 0
        let isLast = indexPath.row == cellModels[indexPath.section].count - 1

        cell.update(with: cellModels[indexPath.section][indexPath.row], isFirst: isFirst, isLast: isLast, isDestructive: isDestructive)

        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
