//
//  Service.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation


protocol ServiceProtocol {
    var baseURL: String {get}
    func getJSON(URL: URL, completion: @escaping ([String: Any]?, Error?) -> Swift.Void)
    
}

class Service: ServiceProtocol {
    
    var baseURL: String  {
        get { preconditionFailure("Необходимо переопределить абстрактное свойство webServiceAddress") }

    }
    
    func getJSON(URL: URL, completion: @escaping ([String: Any]?, Error?) -> Swift.Void) {
        let sharedSession = URLSession.shared
        
        let dataTask = sharedSession.dataTask(with: URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }
            
            if let dataResponse = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String: AnyObject]
                    
                    print("json: \(json), error: \(String(describing: error))")
                    completion(json, nil)
                    return
                    
                } catch let error as NSError {
                    
                    print("Failed to load: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        })
        dataTask.resume()
    }
}
