//
//  APICaller.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import Foundation
import Alamofire
import SwiftyJSON


// isi token
struct Constanta {
    static let headers: HTTPHeaders = [
        "Authorization": "QpwL5tke4Pnpja7X4",
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
}

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Bool?, String) -> Void) {
        completion(nil,"")
        
        let params: [String: Any] = [
            "email": email,
            "password": password,
        ]
        
        let sURL: String = "https://reqres.in/"
         
        AFManager.request(sURL, method: .post, parameters: params, encoding: JSONEncoding.default ,headers: Constanta.headers).responseJSON { (response) in
            print(response)
            switch response.result {
                
            case .success(_):
                print("Login Sukses")
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let status = data["status"].string ?? ""
                        let message = data["message"].string ?? ""
                        
                       
                        if status.lowercased() == "success" {
                            completion(true,"")
                        } else {
                            completion(false,message)
                        }
                        
                    } catch {
                        print("JSON Error")
                    }
                }
            case .failure(let error):
                print(error)
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
    
    // MARK: - GetNotificationFilter
    func getInfoUser(page: Int, completion: @escaping (Result<DataInfo, Error>) -> Void) {
        var params = [
            "page": String(page),
            "per_page": String(6),
        ]
        
        
        let sURL: String = "https://reqres.in/api/users?page=2"
        let e_todos = My.queryParams(url: sURL, params: params).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AFManager.request(e_todos, headers: Constanta.headers) .responseJSON { (response) in
            print(params)
            switch response.result {
                
            case .success(_):
                if let json = response.data {
                    do {
                        let result = try JSONDecoder().decode(DataInfo.self, from: json)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                print("===========================\n\n")
            }
        }
    }
}
