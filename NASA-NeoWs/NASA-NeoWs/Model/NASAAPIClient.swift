//
//  NASAAPIClient.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
class NASAAPIClient {
    static let apiKey = "cmPeNpKaH2oeNUfqFhfnWenrwMk6fBe3q9E09fSu"
    
    enum EndPoints {
        static let baseUrl = "https://api.nasa.gov/neo/rest/v1/feed?api_key=\(NASAAPIClient.apiKey)"
        case getFeed(startDate: String?, endDate: String?)
        
        var stringValue: String {
            switch self {
            case .getFeed(let startDate, let endDate):
                return EndPoints.baseUrl + "&start_date=\(startDate ?? "")&end_date=\(endDate ?? "")"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func getAsteriodFeed(startDate: String? = nil, endData: String? = nil,
                               successHandler: @escaping (_ asteriods: Asteriods) -> Void,
                               errorHandler: @escaping (_ error: Error) -> Void) -> URLSessionDataTask {
        return taskForGetRequest(url: EndPoints.getFeed(startDate: startDate, endDate: endData).url, responseType: Asteriods.self,
                          successHandler: successHandler, errorHandler: errorHandler)
    }
    
    @discardableResult
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, successHandler: @escaping (_ response: ResponseType) -> Void, errorHandler: @escaping (_ error: Error) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data, error: error, responseType: responseType, successHandler: successHandler, errorHandler: errorHandler)
        }
        task.resume()
        return task
    }
    
    class func handleResponse<ResponseType: Decodable>(data: Data?, error: Error?, responseType: ResponseType.Type,
                                                       successHandler: @escaping (_ response: ResponseType) -> Void,
                                                       errorHandler: @escaping (_ error: Error) -> Void) {
        guard let data = data else {
            onMain {
                errorHandler(error!)
                
            }
            return
        }
        
        do {
            let response = try JSONDecoder().decode(responseType, from: data)
            onMain {
                successHandler(response)
            }
        } catch {
            errorHandler(error)
        }
    }
    
    private class func onMain(block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
