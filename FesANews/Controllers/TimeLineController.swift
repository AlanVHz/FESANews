//
//  TimeLineController.swift
//  FesANews
//
//  Created by Alan Vargas on 31.07.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit
import Lottie

class TimeLineController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingAnimation: AnimationView!
  
  var newsList: [NewModel]?
  var selectedNew: NewModel?
  var newsService = NewsService()
  var dateService = DateService()

  override func viewDidLoad() {
    super.viewDidLoad()
    setNewsSnapshotListener()
    setup()
    self.tableView.register( TimeLineCustomCell.self, forCellReuseIdentifier: "TimelineCell")
  }
  
  private func setupUi() {
    self.tableView.separatorColor = UIColor.AppColor.mainBlue
  }

  private func setup() {

    setupUi()
    setAnimation()
    toggleAnimation(play: true)
  }
  
  func toggleAnimation( play: Bool ) {
    loadingAnimation.isHidden = !play
    tableView.isHidden = play
  }
  
  private func setAnimation() {
    loadingAnimation.animation = Animation.named( "loading-toggle" )
    loadingAnimation.loopMode = .loop
    loadingAnimation.play()
  }
  
  private func setNewsSnapshotListener() {
    self.newsService.getNews(success: { (newsList) in
      self.newsList = newsList
      self.toggleAnimation(play: false)
      self.tableView.reloadData()
    }) { (error) in
      }
  }
}

extension TimeLineController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "TimelineCell") as! TimeLineCustomCell
    
    if let news = newsList {
      cell.content = news[indexPath.row].content
      cell.nickname = news[indexPath.row].nickname
      cell.date =
        dateService.dateFormatterFromFirebase(
          date: news[indexPath.row].date ?? Date().description )
      cell.institutionName = news[indexPath.row].institutionName
      cell.layoutSubviews() 
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.newsList?.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedNew = newsList![indexPath.row]
    goToInstitution()
  }
  
  func goToInstitution() {
    performSegue(withIdentifier: "institutionSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let institutionCtr = segue.destination as? InstitutionController else { return }
    institutionCtr.selectedNew = selectedNew
  }
  
}
