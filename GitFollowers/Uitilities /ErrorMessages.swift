//
//  ErrorMessages.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 25/03/2025.
//

import Foundation

enum ErrorMessages: String, Error {
    case invalidUsername  = "This username created an invalid resquest. Please try again."
    case unableToComplete = "Unable to complete your request. Please Check your internet"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidDate = "The data received from the server was invalid. Please try again."  
    case noErro = "There is no an error"
}
