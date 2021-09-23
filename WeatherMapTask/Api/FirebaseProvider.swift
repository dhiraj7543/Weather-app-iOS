//
//  FirebaseProvider.swift
//  WeatherMapTask
//
//  Created by Dheeraj's Mac on 23/09/21.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseProvider {
    private static let _instance = FirebaseProvider()
    
    static var Instance: FirebaseProvider {
        return _instance
    }
    
    var dbRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var weatherRef: DatabaseReference {
        return dbRef.child(Constants.WEATHER)
    }
    
    // save current weather
    func saveCurrentWeather(todayWeather: TodayWeatherViewModel) {
        let uuid = UUID().uuidString
        
        let data: Dictionary<String, Any> = [
            Constants.WEATHER_CITY: todayWeather.cityName!,
            Constants.WEATHER_TEMP: todayWeather.temperature!,
            Constants.WEATHER_CONDITION: todayWeather.weatherCondition!,
            Constants.DATE: self.getCurrentDate(),
            Constants.LATITUDE: String(Coordinate.sharedInstance.latitude),
            Constants.LONGITUDE: String(Coordinate.sharedInstance.longitude)
        ]
        
        weatherRef.child(uuid).setValue(data)
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        
        return currentDate
    }
}
