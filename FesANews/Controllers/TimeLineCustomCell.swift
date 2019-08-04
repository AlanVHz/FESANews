//
//  TimeLineCustomCell.swift
//  FesANews
//
//  Created by Alan Vargas on 3.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation
import UIKit

class TimeLineCustomCell: UITableViewCell {
  
  var institutionName: String?
  var nickname: String?
  var date: Date?
  var content: String?
  
  var nameView: UILabel = {
    var name = UILabel()
    name.translatesAutoresizingMaskIntoConstraints = false
    return name
  }()
  
  var nicknameLabel: UILabel = {
    var nickname = UILabel()
    nickname.translatesAutoresizingMaskIntoConstraints = false
    return nickname
  }()
  
  var dateLabel: UILabel = {
    var dateLabel = UILabel()
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    return dateLabel
  }()
  
  var contentTextView: UILabel = {
    var text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(nameView)
    self.addSubview(nicknameLabel)
    self.addSubview(dateLabel)
    self.addSubview(contentTextView)
    
    setConstraints()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if let institutionName = institutionName {
      nameView.text = institutionName
      nameView.textColor = UIColor.AppColor.mainBlue
    }
    if let nickname = nickname {
      nicknameLabel.text = nickname
      nicknameLabel.textColor = UIColor.AppColor.nickNameGray
      nicknameLabel.font = UIFont(name: "Arial", size: 8.0)
    }
    if let dateL = date {
      dateLabel.text = dateL.description
    }
    if let content = content {
      contentTextView.text = content
    }
  }
  
  private func setConstraints() {
    self.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
    nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    nameView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    nameView.font = UIFont(name: "Ubuntu-Bold.ttf", size: 22.0)
    
    nicknameLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 0.0).isActive = true
    nicknameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    nicknameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    
    dateLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 0.0).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    
    contentTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    contentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentTextView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented!")
  }
  
}
