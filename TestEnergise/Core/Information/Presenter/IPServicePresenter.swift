//
//  IPServicePresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import Foundation
import Alamofire

class IPServicePresenter {
    
    private let baseURL = "https://ipwho.is/"
    
    func fetchIPInfo(for ipAddress: String? = nil, completion: @escaping (Result<IPInfoModel, Error>) -> Void) {
        
        var lang = "?lang=en"
        let currentLanguage = Locale.current.region
        if currentLanguage == "DE" {
            lang = "?lang=de"
        }
        let urlString: String
        if let ip = ipAddress, !ip.isEmpty {
            urlString = baseURL + ip + lang
        } else {
            urlString = baseURL + lang
        }

        AF.request(urlString)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: IPInfoModel.self) { response in
                switch response.result {
                case .success(let ipInfo):
                    if let _ = ipInfo.success {
                        completion(.success(ipInfo))
                    } else {
                        completion(.failure(IPError.apiError(ipInfo.message ?? NSLocalizedString("unknown_error", comment: ""))))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
