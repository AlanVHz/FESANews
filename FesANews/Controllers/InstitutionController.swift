//
//  InstitutionController.swift
//  FesANews
//
//  Created by Alan Vargas on 5.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class InstitutionController: UIViewController {
  
  @IBOutlet weak var nicknameLabel: UILabel!
  var selectedNew: NewModel?
  var institutionsList: institutionsList?
  let institutionService = InstitutionsService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
  }
  
  private func setup() {
    setupUi()
    setInstitutionsSnapshotListener()
  }
  
  private func setInstitutionsSnapshotListener() {
    institutionService.getInstitutions(success: { (institutionsList) in
      self.institutionsList = institutionsList
  
    }) { (error) in
      
    }
  }
  
  private func setupUi() {
    self.navigationItem.title = selectedNew?.institutionName
    self.navigationItem.largeTitleDisplayMode = .never
    
    nicknameLabel.text = selectedNew?.nickname
  }
  
  

}
