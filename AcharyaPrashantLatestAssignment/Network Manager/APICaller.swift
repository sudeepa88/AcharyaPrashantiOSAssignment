//
//  APICaller.swift
//  AcharyaPrashantLatestAssignment
//
//  Created by Sudeepa Pal on 17/12/25.
//

import Foundation



class APICaller {
    public static func getPostData(limit: Int, completion: @escaping (_ testResult: Result<[ResponseModel], Error>) -> Void) {
        
        
        
        var components = URLComponents(string: NetworkConstants.shared.serverAddress)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        
        //1. Converting String into an url
        guard let url = components?.url else {
                    completion(.failure(URLError(.badURL)))
                    return
                }
        
        
        //2. URL Session task
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            //Assuming best case
            if error == nil, let daata = dataResponse, let jsonResponse = try? JSONDecoder().decode([ResponseModel].self, from: daata) {
                //print("The JSON Response is", jsonResponse)
                completion(.success(jsonResponse))
                
            } else {
                completion(.failure( error!))
                print("problem in JSON Decoder")
            }
        }.resume()
        
    }
}
