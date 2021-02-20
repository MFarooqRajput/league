//
//  ViewController.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import UIKit

class MatchListViewController: UIViewController {
    
    @IBOutlet weak var matchListTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var presenter: MatchListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MatchListPresenter(view: self)
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        configTabeleView()
        presenter.fetchMatches()
    }
    
    func configTabeleView() {
        matchListTableView.register(UINib(nibName: "MatchListTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchListCell")
        
        matchListTableView.dataSource = self
        matchListTableView.delegate = self
        matchListTableView.tableFooterView = UIView(frame: .zero)
        
        matchListTableView.register(UINib(nibName: "MatchListTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MatchListHeader")
    }
    
    private func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func hideError() {
    }
    
    private func activityIndicatorAnimating(_ animating: Bool ) {
        animating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segues.matchDetailSegue {
            
            if let matchDetailViewController = segue.destination as? MatchDetailViewController {
                matchDetailViewController.matchId = presenter.matchId
            }
        }
    }
}

// MARK: - PropertyListView protocol methods
extension MatchListViewController: MatchListView {
    
    func reloadView() {
        matchListTableView.reloadData()
    }
    
    func showErrorView(_ error: String) {
        self.showError(error)
    }
    
    func hideErrorView() {
        self.hideError()
    }
    
    func activityIndicatorAnimatingView(animating: Bool) {
        activityIndicatorAnimating(animating)
    }
    
}

// MARK: - UITableViewDataSource
extension MatchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchListHeader") as? MatchListTableViewHeader  else {
            fatalError("The dequeued cell is not an instance of MatchListHeader")
        }
        
        if let section =  presenter.getHeaderFor(timeSlot: section) {
            headerView.set(with: section.date, flagUrl: section.flagUrl, name: section.name)
        }
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getSlotsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getMatchesCount(timeSlot: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchListCell") as? MatchListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MatchListCell")
        }
        
        if let match =  presenter.getMatchAt(timeSlot: indexPath.section, row: indexPath.row) {
            cell.set(with: match)
        }
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension MatchListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectMacthAtIndex(section: indexPath.section, row: indexPath.row)
        performSegue(withIdentifier: Constants.Segues.matchDetailSegue, sender: self)
        
    }
}
