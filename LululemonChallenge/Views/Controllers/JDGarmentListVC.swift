//
//  JDGarmentListVC.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

final class JDGarmentListVC: UITableViewController, GarmentAddDelegate {
    private enum Segments {
        static let first = "Alpha"
        static let second = "Creation Time"
    }
    
    private let headerHeight: CGFloat = 40
    private let rowHeight: CGFloat = 45
    private var sortByAlpha = true
    
    private var garmentViewModels = [JDGarmentViewModel]()
    private let garmentAddVC = JDGarmentAddVC()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [Segments.first, Segments.second])
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromUserDefaults()
        setupDelegates()
        setupButtonTargets()
        setupNavigationBar()
        registerCells()
        configureTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        JDGarmentViewModel.saveToUserDefaults(viewModels: self.garmentViewModels)
    }
    
    private func loadDataFromUserDefaults() {
        let garments = JDGarmentViewModel.loadFromUserDefaults()
        garmentViewModels = garments.map({return JDGarmentViewModel(garment: $0)})
    }
    
    private func setupDelegates() {
        garmentAddVC.delegate = self
    }
    
    private func setupButtonTargets() {
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGarment))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "List"
    }
    
    private func registerCells() {
        tableView.register(JDTableViewCell.self, forCellReuseIdentifier: JDTableViewCell.reuseIdentifier())
    }
    
    private func configureTableView() {
        tableView.allowsSelection = false
    }
    
    // MARK: - Helper Methods
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupSegmentedControl() -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: headerHeight))
        let tvWidth = self.tableView.frame.width
        containerView.addSubview(segmentedControl)
        segmentedControl.constrainWidthToConstant(tvWidth-32, identifier: "GarmentListViewController.segmentedControl.widthAnchor")
        segmentedControl.centerInSuperview(identifier: "GarmentListViewController.segmentedControl.centerInSuperviewAnchors")
        return containerView
    }

    private func sortGarmentViewModels() -> [JDGarmentViewModel] {
        sortByAlpha ?
        garmentViewModels.sorted { $0.garmentName < $1.garmentName } :
        garmentViewModels.sorted { $0.creationDate < $1.creationDate }
    }
    
    // MARK: - Selector Methods
    @objc private func addGarment(sender: UIButton) {
        let navController = UINavigationController(rootViewController: garmentAddVC)
        navController.modalPresentationStyle = .pageSheet
        navController.presentationController?.delegate = navController.viewControllers[0] as! JDGarmentAddVC
        present(navController, animated: true)
    }
    
    @objc private func segmentedControlValueChanged() {
        sortByAlpha = segmentedControl.selectedSegmentIndex == 0 ? true : false
        reloadTableView()
    }
    
    // MARK: - Delegate Methods
    func garmentAdded(_ garment: JDGarment) {
        garmentViewModels.append(JDGarmentViewModel(garment: garment))
        reloadTableView()
    }
}

extension JDGarmentListVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JDTableViewCell.reuseIdentifier(), for: indexPath) as! JDTableViewCell
        let garmentViewModel = sortGarmentViewModels()[indexPath.row]
        cell.garmentViewModel = garmentViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garmentViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = setupSegmentedControl()
        headerView.backgroundColor = .systemGray2
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
}
