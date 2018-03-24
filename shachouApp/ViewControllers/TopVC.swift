import UIKit
import SnapKit

final class TopVC: UIViewController {
    
    let model = TopModel()
    
    var numOfShop: Int {
        return model.shops.count
    }
    
    //    private lazy var tebleView: UITableView = {
    //        let tableView = UITableView()
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        tableView.register(TopCell.self, forCellReuseIdentifier: "TopCell")
    //        tableView.estimatedRowHeight = 200
    //        tableView.rowHeight = UITableViewAutomaticDimension
    //        tableView.separatorStyle = .none
    //        return tableView
    //    }()
    //何故か動かない！！！！！Fuxx！！！！
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopCell.self, forCellReuseIdentifier: "TopCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        
        self.tableView.reloadData()
        self.model.getShopInfo {
            self.tableView.reloadData()
        }
        print(model.shops)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //選択されたセルのハイライトを解除
        if (self.tableView.indexPathForSelectedRow != nil) {
            self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetch() {
        self.model.getShopInfo{
            self.tableView.reloadData()
        }
    }
    
    func shopVC(index: Int) -> ShopVC {
        let shopVC = ShopVC(shopID: self.model.shops[index].id)
        return shopVC
    }
}

extension TopVC: UITableViewDataSource {
    
    
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfShop
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell") as! TopCell
        
        cell.configure(self.model.shops[indexPath.row]) { image in
            if let image = image {
                self.model.shops[indexPath.row].image = image
            }
        }
        return cell
    }
}

extension TopVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.shopVC(index: indexPath.row)
        let naviVC = UINavigationController(rootViewController: nextVC)
        nextVC.view.backgroundColor = UIColor.gray
        self.present(naviVC, animated: true, completion: nil)
    }
}
