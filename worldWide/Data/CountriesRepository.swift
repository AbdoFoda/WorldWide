//
//  CountriesReoository.swift
//  worldWide
//
//  Created by Abdo on 10/18/18.
//  Copyright © 2018 Abdo. All rights reserved.
//

import Foundation
import Alamofire
class CountriesRepository{
    static let url = "https://restcountries.eu/rest/v2/all"
    
    
    static func getAllCountriesData(dataCompletion : @escaping ([Country])->Void ) {
        Alamofire.request(url).responseJSON {response in
            switch response.result{
                case .success:
                    do{
                        try dataCompletion(JSONDecoder().decode([Country].self,from: response.data!))
                
                    }catch{
                        print(error)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
