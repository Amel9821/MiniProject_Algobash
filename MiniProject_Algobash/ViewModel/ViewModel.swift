//
//  ViewModel.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import Foundation

//MARK: - Data Info
final class ViewModel: NSObject {
    private(set) var info : [User] = [] {
        didSet {
            self.loadedData()
        }
    }
    
    private(set) var isEmpty : Bool = false {
        didSet {
            self.dataEmpty()
        }
    }
    
    var loadedData : (() -> ()) = {}
    var dataEmpty : (() -> ()) = {}
    
    func fetchData(page: Int) {
        if page == 1 {
            self.info.removeAll()
        }
        
        APICaller.shared.getInfoUser(page: page, completion: { result in
            switch result {
            case .success(let model):
                if model.data != nil {
                    guard let result = model.data else {
                        return
                    }
                    
                    for i in result {
                        self.info.append(i)
                    }
                    
                    if result.count == 0 {
                        //print("Education count 0")
                        self.isEmpty = true
                    }
                }
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                print("===========================\n\n")
            }
        })
    }
}
