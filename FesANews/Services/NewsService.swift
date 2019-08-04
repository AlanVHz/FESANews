//
//  NewsService.swift
//  FesANews
//
//  Created by Alan Vargas on 1.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import Foundation
import CodableFirebase

class NewsService: TimelineProtocol {

  func getNews(success: @escaping ( newsList ) -> Void, failure: @escaping (String) -> Void) {
    Fire.shared.database.collection("news").addSnapshotListener { (query, error) in
      if let err = error { failure( err.localizedDescription ) }
      
      else {
        var newsListObj = newsList()
        if let news = query?.documents {
          if news.isEmpty { print("There's no News") }
          
          else {
            for data in news {
              
              let myNew = try! FirebaseDecoder().decode( NewModel.self, from: data.data() )
              newsListObj.append( myNew )
              
            }
          }
        }
        success( newsListObj )
      }
    }
  }
  
}

