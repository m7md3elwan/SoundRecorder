//
//  RecordingsViewController.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class RecordingsViewController: UIViewController, Messagable {
    
    // MARK:- Constants
    struct Constants {
        static let cellIdentifier = "RecordTableViewCell"
    }
    
    // MARK:- Properties
    var viewModel: RecordingsViewModelType!
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var playerView: RecordPlayerView!

    // MARK:- UIViewController
    override func viewDidLoad() {
        setupTableView()
        registerCells()
        viewModel.viewLoaded()
    }
    
    // MARK:- Methods
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func registerCells() {
        let recordCell = UINib(nibName: Constants.cellIdentifier, bundle:nil)
        tableView.register(recordCell, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func getUITableViewRowAction(from action: EditActionViewModel)  -> UITableViewRowAction {
        let rowAction = UITableViewRowAction.init(style: .default, title: action.title) { (_, _) in
            action.completion()
        }
        rowAction.backgroundColor = UIColor.init(patternImage: action.image)
        return rowAction
    }
    
    @available(iOS 11.0, *)
    func getUITableViewRowAction(from action: EditActionViewModel)  -> UIContextualAction {
        let rowAction = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
            action.completion()
            completion(true)
        }
        rowAction.image = action.image
        rowAction.backgroundColor = action.backgroundColor
        return rowAction
    }
    
    // MARK:- Actions
    @IBAction func DoneButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension RecordingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbetOfRecordings()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! RecordTableViewCell
        if let recordViewModel = viewModel.recordViewModelAt(index: indexPath.row) {
            cell.configure(viewModel: recordViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userDidSelectItem(at: indexPath.row)
    }
    
    // Used as fallback to iOS 11.0
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return viewModel.editActionsForItemAt(index: indexPath.row).map{ getUITableViewRowAction(from: $0) }
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions = UISwipeActionsConfiguration(actions: viewModel.editActionsForItemAt(index: indexPath.row).map{ getUITableViewRowAction(from: $0) })
        actions.performsFirstActionWithFullSwipe = false
        return actions
    }
}

// MARK:- RecordingsViewModelDelegate
extension RecordingsViewController: RecordingsViewModelDelegate {
    func playingStateUpdated(currentTime: String, duration: String, percentage: Double) {
        playerView.currentTimeLabel.text = currentTime
        playerView.durationLabel.text = duration
        playerView.slider.value = Float(percentage)
    }
    
    func showAudioPlayer(viewModel: RecordViewModel) {
        playerView.isHidden = false
        playerView.trackNameLabel.text = viewModel.name
        playerView.durationLabel.text = viewModel.duration
    }
    
    func hideAudioPlayer() {
        playerView.isHidden = true
    }
    
    func recordingsUpdated() {
        tableView.reloadData()
    }
}
