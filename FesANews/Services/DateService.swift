//
//  DateService.swift
//  FesANews
//
//  Created by Alan Vargas on 3.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation

class DateService {
  
  let dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
  
  func dateFormatterFromFirebase( date:String ) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: date) ?? Date()
  }
  
}
