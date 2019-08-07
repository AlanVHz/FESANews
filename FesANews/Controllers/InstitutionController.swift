
import UIKit

class InstitutionController: UIViewController {
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var institutionTableView: UITableView!
  
  var selectedNew: NewModel?
  var institutionsList: institutionsList?
  let institutionService = InstitutionsService()
  var dateService = DateService()
  var newsService: NewsService?
  var newsList: newsList?
  var filteredList = [NewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    self.institutionTableView.register( TimeLineCustomCell.self, forCellReuseIdentifier: "InstitutionCell")
    setupUi()
    setInstitutionsSnapshotListener()
  }
  
  private func setInstitutionsSnapshotListener() {
    institutionService.getInstitutions(success: { (institutionsList) in
      self.institutionsList = institutionsList
      self.doFiltering()
    }) { (error) in
      
    }
  }
  
  func doFiltering() {
    for new in newsList ?? [] {
      if new.nickname == selectedNew?.nickname {
        
        filteredList.append( new )
      }
    }
    institutionTableView.reloadData()
  }
  
  private func setupUi() {
    self.navigationItem.title = selectedNew?.institutionName
    self.navigationItem.largeTitleDisplayMode = .never
    self.institutionTableView.separatorColor = UIColor.AppColor.mainBlue
    
    nicknameLabel.text = selectedNew?.nickname
  }
}

extension InstitutionController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.institutionTableView.dequeueReusableCell(withIdentifier: "InstitutionCell") as! TimeLineCustomCell
    
    cell.content = filteredList[indexPath.row].content
    cell.nickname = filteredList[indexPath.row].nickname
    cell.date =
      dateService.dateFormatterFromFirebase(
        date: filteredList[indexPath.row].date ?? Date().description )
    cell.institutionName = filteredList[indexPath.row].institutionName
    cell.selectionStyle = .none
    cell.layoutSubviews()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.filteredList.count
  }
}
