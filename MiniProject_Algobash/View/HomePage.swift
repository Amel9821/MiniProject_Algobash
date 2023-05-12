//
//  HomePage.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import UIKit
import SDWebImage
import Photos
import CropViewController

class HomePage: UIViewController {
    var viewModel: ViewModel!
    var pageNumber = 1
    let spinner = UIActivityIndicatorView()
    private var label_kosong = UILabel()
    private var imgViewNoData = UIImageView()
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callViewModel()
        setNav()

    }
    
    func callViewModel() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        self.viewModel = ViewModel()
        pageNumber = 1
        
        self.viewModel.fetchData(page: pageNumber)
        self.viewModel.loadedData = {
            if self.pageNumber == 1 {
                self.tableView.showsVerticalScrollIndicator = false
                self.tableView.dataSource = self
                self.tableView.delegate = self
                let nib = UINib.init(nibName: "NotificationCell", bundle: nil)
                self.tableView.register(nib, forCellReuseIdentifier: "NotificationCell")
                self.tableView.separatorStyle = .none
                
                self.spinner.color = .darkGray
                self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(44))
                self.tableView.tableFooterView = self.spinner
                self.tableView.tableFooterView?.isHidden = false
            }
            //print("List Keupdate")
            self.stopSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.updateUI()
                LoadingOverlay.shared.hideOverlayView()
            }
        }
        
        self.viewModel.dataEmpty = {
            LoadingOverlay.shared.hideOverlayView()
            if self.pageNumber == 1 {
                self.showNoDataLabel()
            }
            self.stopSpinner()
            self.tableView.reloadData()
        }
    }
    
    func stopSpinner() {
        self.spinner.stopAnimating()
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func updateUI() {
        hideNoDataLabel()
        
        
        if pageNumber == 1 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                //self.labelTotal.text = "Total: \(self.viewModel.count)"
                //LoadingOverlay.shared.hideOverlayView()
                self.spinner.stopAnimating()
                LoadingOverlay.shared.hideOverlayView()
                
                self.tableView.reloadData()
            }
        } else {
            
            //spinner.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
           
        }
    }
    
    func hideNoDataLabel() {
        label_kosong.isHidden = true
        imgViewNoData.isHidden = true
    }
    
    func showNoDataLabel() {
        imgViewNoData.isHidden = false
        label_kosong.isHidden = false
    }
    
    func setNav() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .black
        
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth - (screenWidth/3), height: 30.0))
        let tapGestureback = UITapGestureRecognizer(target: self, action: #selector(viewTapped(tapGestureRecognizer:)))
        customView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(tapGestureback)
        
        let button = UIButton.init(type: .custom)
        button.setBackgroundImage(UIImage(named: "IconBack"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 8, width: 10.0, height: 15.0)
        button.addTarget(self, action: #selector(menuBack), for: .touchUpInside)
        customView.addSubview(button)
        
        let label_nav = UILabel(frame: CGRect(x: 30, y: 0, width: screenWidth - (screenWidth/3), height: 30.0))
        label_nav.text = "Kembali"
        label_nav.textColor = UIColor.white
        label_nav.textAlignment = .left
        label_nav.font = UIFont(name: "OpenSans-Medium", size: 20)
        customView.addSubview(label_nav)
        
        let leftButton = UIBarButtonItem(customView: customView)
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @objc func menuBack(sender: UIButton!) {
        self.dismiss(animated: true)
    }


   

}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCard", for: indexPath) as! UserCard
        let dict = viewModel.info[indexPath.row]
        let url = dict.avatar ?? ""
        let url_gambar = URL(string: "https://reqres.in/\(url)")
        cell.imageProfil.sd_setImage(with: url_gambar, placeholderImage: UIImage(named: "ProfilePlaceholder"))
        cell.labelEmail.text = dict.email ?? ""
        let firstName = dict.firstName ?? ""
        let lastName = dict.lastName ?? ""
        cell.labelNama.text = "\(firstName) \(lastName)"
        
        cell.selectionStyle = UserCard.SelectionStyle.none
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = viewModel.info[indexPath.row]
        
        
    }
    
}
