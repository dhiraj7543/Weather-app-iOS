//
//  OpenWeatherMapClient.swift
//  WeatherMapTask
//
//  Created by Dheeraj's Mac on 23/09/21.
//

import Foundation
import Alamofire

class OpenWeatherMapClient {
    static let client = OpenWeatherMapClient()
    
    fileprivate let apiKey = "0c890fd5b0fd9a515d9a1350ed245eec"

    
    lazy var baseUrl: URL = {
        return URL(string: Constants.API_BASE_URL)!
    }()
    
    
    typealias TodayWeatherCompletionHandler = (TodayWeather?, OpenWeatherMapError?) -> Void
    typealias ForecastWeatherCompletionHandler = ([ForecastWeather]?, OpenWeatherMapError?) -> Void
    
    func getTodayWeather(at coordinate: Coordinate, completionHandler completion: @escaping TodayWeatherCompletionHandler) {
        
        guard let url = URL(string: Constants.API_ENDPOINT_CURRENT_WEATHER, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let parameters: Parameters = self.buildParameters(coordinate: coordinate)
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let JSON = response.result.value as? Dictionary<String, AnyObject> else {
                completion(nil, .invalidaData)
                return
            }
            
            print (url)
            print (parameters)
            print (JSON)
            
            if response.response?.statusCode == 200 {
                guard let currentWeather = TodayWeather(json: JSON) else {
                    completion(nil, .jsonParsingFailure)
                    
                    print (JSON)
                    return
                }
                
                completion(currentWeather, nil)
            }
            else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
    
    //Alamofire
    func getForecastWeather(at coordinate: Coordinate, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        
        guard let url = URL(string: Constants.API_ENDPOINT_FORECAST_WEATHER, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let parameters: Parameters = self.buildParameters(coordinate: coordinate)
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let JSON = response.result.value else {
                completion(nil, .invalidaData)
                return
            }
            
            print (url)
            print (parameters)
            print (JSON)
            
            if response.response?.statusCode == 200 {
                var forecasts: [ForecastWeather] = []
                
                print (JSON)
                
                if let dict = JSON as? Dictionary<String, AnyObject>{
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        for obj in list {
                            let forecast = ForecastWeather(json: obj)
                            forecasts.append(forecast!)
                        }
                    }
                }
                
                completion(forecasts, nil)
            }
            else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
    
    
    func buildParameters(coordinate: Coordinate) -> Parameters {
        let parameters: Parameters = [
            "appid": self.apiKey,
            "units": "metric",
            "lat": String(coordinate.latitude),
            "lon": String(coordinate.longitude)
        ]
        
        return parameters
    }
}
