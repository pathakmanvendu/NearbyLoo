//
//  NetworkManager.swift
//  GetNearbyActivity
//
//  Created by manvendu pathak  on 20/08/24.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var response: ToiletData?
    
    func fetchNearbyToilets(latitude: Double, longitude: Double){
        let apiKey = "019ef941b4ec4fe8a14fa09a15160ab5"
        let urlString = "https://api.geoapify.com/v2/places?categories=building.toilet&filter=circle:\(longitude),\(latitude),5000&bias=proximity:\(longitude),\(latitude)&limit=20&apiKey=019ef941b4ec4fe8a14fa09a15160ab5"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error fetching data \(error)")
                return
            }
            
            guard let data = data else {
                print("Invalid Data")
                return
            }
            
            do{
                let apiResponse = try JSONDecoder().decode(ToiletData.self, from: data)
                DispatchQueue.main.async{
                    print(apiResponse)
                    self.response = apiResponse
                }
            }catch let jsonError{
                print("Failed to decode JSON \(jsonError)")
            }
        }.resume()
    }
}
