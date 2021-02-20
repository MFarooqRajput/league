//
//  MatchDetailViewController.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var infoBarButton: UIBarButtonItem!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var liveStatusDetailLabel: UILabel!
    
    @IBOutlet var awayTeamFlagImageView: UIImageView!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet var homeTeamFlagImageView: UIImageView!
    
    @IBOutlet weak var oddsOneLabel: UILabel!
    @IBOutlet weak var oddsTwoLabel: UILabel!
    @IBOutlet weak var oddsThreeLabel: UILabel!
    
    @IBOutlet weak var matchDetailTeamTableView: UITableView!
    @IBOutlet weak var matchDetailOddsTableView: UITableView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var teamView: UIView!
    
    @IBOutlet weak var leftOneLabel: UILabel!
    @IBOutlet weak var leftTwoLabel: UILabel!
    @IBOutlet weak var leftThreeLabel: UILabel!
    @IBOutlet weak var leftFourLabel: UILabel!
    @IBOutlet weak var leftFiveLabel: UILabel!
    
    @IBOutlet weak var rightOneLabel: UILabel!
    @IBOutlet weak var rightTwoLabel: UILabel!
    @IBOutlet weak var rightThreeLabel: UILabel!
    @IBOutlet weak var rightFourLabel: UILabel!
    @IBOutlet weak var rightFiveLabel: UILabel!
    
    var presenter: MatchDetailPresenter!
    var matchId: Int!
    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MatchDetailPresenter(view: self)
        setupView()
    }
    
    func setupView() {
        teamView.isHidden = true
        configTabeleView()
        presenter.fetchMatchDetail(matchId: matchId)
    }
    
    func configTabeleView() {
        matchDetailTeamTableView.register(UINib(nibName: "MatchDetailTeamTableViewCell", bundle: nil), forCellReuseIdentifier:"MatchDetailTeamCell")
        
        matchDetailTeamTableView.dataSource = self
        matchDetailTeamTableView.delegate = self
        matchDetailTeamTableView.tableFooterView = UIView(frame: .zero)
        
        matchDetailOddsTableView.register(UINib(nibName: "MatchDetailOddsTableViewCell", bundle: nil), forCellReuseIdentifier:"MatchDetailOddsCell")
        
        matchDetailOddsTableView.dataSource = self
        matchDetailOddsTableView.delegate = self
        matchDetailOddsTableView.tableFooterView = UIView(frame: .zero)
        
        matchDetailTeamTableView.register(UINib(nibName: "MatchDetailTeamTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MatchDetailTeamHeader")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        if (teamView.isHidden) {
            teamView.isHidden = false
            self.navigationItem.setHidesBackButton(true, animated: true)
        } else {
            teamView.isHidden = true
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    
    private func updateOdds() {
        
        let odds = presenter.getOdds()
        
        if let firstOdd = odds.firstOdd {
            oddsOneLabel.text = firstOdd
        }
        
        if let secondOdd = odds.secondOdd {
            oddsTwoLabel.text = secondOdd
        }
        
        if let thirdOdd = odds.thirdOdd {
            oddsThreeLabel.text = thirdOdd
        }
    }
    
    private func updateHeader() {
        
        let header = presenter.getHeader()
        self.navigationItem.titleView = navTitleWithImageAndText(titleText: header.name, imageName: header.flag)
    }
    
    private func updateMatchDetail() {
        
        let matchDetail = presenter.getMatchDetail()
        
        if let date = matchDetail.date {
            dateLabel.text = date
        }
        
        if matchDetail.status == "Live" {
            statusLabel.isHidden = false
            liveStatusDetailLabel.isHidden = false
            statusLabel.text = "LIVE!"
            liveStatusDetailLabel.text = matchDetail.liveStatusDetail
        } else {
            statusLabel.isHidden = true
            liveStatusDetailLabel.isHidden = true
        }
        
        homeTeamNameLabel.text = matchDetail.homeTeamName
        awayTeamNameLabel.text = matchDetail.awayTeamName
        scoreLabel.text = matchDetail.score
        
        guard let homeTeamFlagUrl =  URL(string: "\(Constants.imageBaseUrl)\(matchDetail.homeTeamFlag)"), let awayTeamFlagUrl =  URL(string: "\(Constants.imageBaseUrl)\(matchDetail.awayTeamFlag)") else {
            return
        }
        
        homeTeamFlagImageView.setImage(with: homeTeamFlagUrl, placeHolder: #imageLiteral(resourceName: "flag"))
        awayTeamFlagImageView.setImage(with: awayTeamFlagUrl, placeHolder: #imageLiteral(resourceName: "flag"))
    }
    
    private func updateTeamsForm() {
        
        let tamsForm = presenter.getTeamsForm()
        
        if (tamsForm.homeTeam.form.count > 0 ){
            leftOneLabel.setRoundedLabel(type: getResultType(result: tamsForm.homeTeam.form[0].row))
            leftTwoLabel.setRoundedLabel(type: getResultType(result: tamsForm.homeTeam.form[1].row))
            leftThreeLabel.setRoundedLabel(type: getResultType(result: tamsForm.homeTeam.form[2].row))
            leftFourLabel.setRoundedLabel(type: getResultType(result: tamsForm.homeTeam.form[3].row))
            leftFiveLabel.setRoundedLabel(type: getResultType(result: tamsForm.homeTeam.form[4].row))
        }  else {
            leftOneLabel.setRoundedLabel(type: .empty)
            leftTwoLabel.setRoundedLabel(type: .empty)
            leftThreeLabel.setRoundedLabel(type: .empty)
            leftFourLabel.setRoundedLabel(type: .empty)
            leftFiveLabel.setRoundedLabel(type: .empty)
        }
        
        if (tamsForm.awayTeam.form.count > 0 ){
            rightOneLabel.setRoundedLabel(type: getResultType(result: tamsForm.awayTeam.form[0].row))
            rightTwoLabel.setRoundedLabel(type: getResultType(result: tamsForm.awayTeam.form[1].row))
            rightThreeLabel.setRoundedLabel(type: getResultType(result: tamsForm.awayTeam.form[2].row))
            rightFourLabel.setRoundedLabel(type: getResultType(result: tamsForm.awayTeam.form[3].row))
            rightFiveLabel.setRoundedLabel(type: getResultType(result: tamsForm.awayTeam.form[4].row))
        } else {
            rightOneLabel.setRoundedLabel(type: .empty)
            rightTwoLabel.setRoundedLabel(type: .empty)
            rightThreeLabel.setRoundedLabel(type: .empty)
            rightFourLabel.setRoundedLabel(type: .empty)
            rightFiveLabel.setRoundedLabel(type: .empty)
        }
    }
    
    private func updateProgress() {
        
        let progress = presenter.getProgress()
        progressView.progress = progress
        progressView.trackTintColor = Constants.Color.progressColor
        progressView.progressTintColor = Constants.Color.progressFillColor
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
    
    
    
    
    
    // MARK: -
    private func navTitleWithImageAndText(titleText: String, imageName: String) -> UIView {

        // Creates a new UIView
        let titleView = UIView()

        // Creates a new text label
        let label = UILabel()
        label.text = " " + titleText
        //
        
        label.font = label.font.withSize(12)
        label.sizeToFit()
        
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center

        // Creates the image view
        let image = UIImageView()
        //image.image = UIImage(named: imageName)
        
        if let url =  URL(string: "\(Constants.imageBaseUrl)\(imageName)") {
            image.setImage(with: url, placeHolder: #imageLiteral(resourceName: "tournament"))
        }

        // Maintains the image's aspect ratio:
        let imageAspect = image.image!.size.width / image.image!.size.height

        // Sets the image frame so that it's immediately before the text:
        let imageX = label.frame.origin.x - label.frame.size.height * imageAspect
        let imageY = label.frame.origin.y

        let imageWidth = label.frame.size.height * imageAspect
        let imageHeight = label.frame.size.height

        image.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)

        image.contentMode = UIView.ContentMode.scaleAspectFit

        // Adds both the label and image view to the titleView
        titleView.addSubview(label)
        titleView.addSubview(image)

        // Sets the titleView frame to fit within the UINavigation Title
        titleView.sizeToFit()

        return titleView

    }
    
    private func getResultType(result: String) -> LabelType {
        
        if (result == "W") {
            return .win
        } else if (result == "D") {
            return .draw
        } else if (result == "L") {
            return .lost
        }
        return .empty
    }
}

// MARK: - PropertyListView protocol methods
extension MatchDetailViewController: MatchDetailView {
    
    func updateMatchDetailView(isOddsAvail: Bool) {
        
        if isOddsAvail {
            teamView.isHidden = true
            updateOdds()
            matchDetailOddsTableView.reloadData()
        } else {
            teamView.isHidden = false
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
        
        updateHeader()
        updateMatchDetail()
        updateTeamsForm()
        updateProgress()
        matchDetailTeamTableView.reloadData()
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
extension MatchDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == matchDetailTeamTableView {
            guard let cellHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchDetailTeamHeader") as? MatchDetailTeamTableViewHeader  else {
                fatalError("The dequeued cell is not an instance of MatchDetailTeamHeader")
            }
            
            return cellHeader
        }
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == matchDetailTeamTableView {
            return presenter.getTeamsCount()
        } else {
            return presenter.getOddsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == matchDetailTeamTableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailTeamCell") as? MatchDetailTeamTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MatchDetailTeamCell")
            }
            
            if let team =  presenter.teamAt(index: indexPath.row) {
                cell.set(with: team)
            }
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = Constants.Color.cellEvenColor
            } else {
                cell.backgroundColor = Constants.Color.cellOddColor
            }
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailOddsCell") as? MatchDetailOddsTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MatchDetailOddsCell")
            }
            
            if let odds =  presenter.oddsAt(index: indexPath.row) {
                cell.set(with: odds)
            }
            
            return cell
        }
        
    }
}

// MARK: - UITableViewDelegate
extension MatchDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == matchDetailTeamTableView {
            return 24
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == matchDetailTeamTableView {
            return 28
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
