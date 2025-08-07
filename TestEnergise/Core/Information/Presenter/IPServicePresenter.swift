//
//  IPServicePresenter.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import Foundation
import Alamofire

class IPServicePresenter: IPServicePresenterProtocol {
    
    weak var view: InformationViewProtocol?
    
    private let baseURL = "https://ipwho.is/"
    
    func viewDidLoad() {
        fetchIPInfo()
    }
    
    func fetchIPInfo(for ipAddress: String? = nil) {
        
        self.view?.showLoadingIndicator()
        
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
            .responseDecodable(of: IPInfoModel.self) { [weak self] response in
                guard let self = self else {
                    return
                }
                self.view?.hideLoadingIndicator()
                
                switch response.result {
                case .success(let ipInfo):
                    if let _ = ipInfo.success, ipInfo.success == true {
                        DispatchQueue.main.async {
                            self.view?.updateUI(with: ipInfo)
                        }
                    } else {
                        let errorMessage = IPError.apiError(ipInfo.message ?? "").errorDescription ?? NSLocalizedString("unknown_error", comment: "")
                        self.view?.showErrorMessage(errorMessage)
                    }
                case .failure(let error):
                    self.view?.showErrorMessage(error.localizedDescription)
                }
            }
    }

}
