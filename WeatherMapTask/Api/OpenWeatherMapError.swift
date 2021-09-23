//
//  OpenWeatherMapError.swift
//  WeatherMapTask
//
//  Created by Dheeraj's Mac on 23/09/21.
//

import Foundation

enum OpenWeatherMapError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidaData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
}

