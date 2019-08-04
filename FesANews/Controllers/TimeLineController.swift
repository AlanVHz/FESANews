//
//  TimeLineController.swift
//  FesANews
//
//  Created by Alan Vargas on 31.07.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class TimeLineController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var newsList: [NewModel]?
  var newsService = NewsService()
  var dateService = DateService()

  override func viewDidLoad() {
    super.viewDidLoad()
    setNewsSnapshotListener()
    
    self.tableView.register( TimeLineCustomCell.self, forCellReuseIdentifier: "TimelineCell")
    /*self.tableView.estimatedRowHeight = 150
    self.tableView.rowHeight = UITableView.automaticDimension*/
  }
  
  private func setNewsSnapshotListener() {
    self.newsService.getNews(success: { (newsList) in
      self.newsList = newsList
      
      self.tableView.reloadData()
    }) { (error) in
      }
  }
}

extension TimeLineController: UITableViewDelegate, UITableViewDataSource {
  
  struct cellData {
    
    let institutionName: String?
    let nickname: String?
    let date: Date?
    let content: String?
    
  }
  
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
  
}
