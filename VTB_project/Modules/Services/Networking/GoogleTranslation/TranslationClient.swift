//
//  TranslationClient.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import GUNetworkLayer


class TranslationClient {

//    MARK: - Properties

    var baseURL = URL(string: "https://google-translate1.p.rapidapi.com")!
    var boundary = "Boundary-\(UUID().uuidString)"
    var headers: HTTPHeaders

    private let networkManager: ApiClient
    private var settings: ClientSettings

//    MARK: - Life cycle


    init() {
        headers = [
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": "8ce856b7e5msh89f53e186525d37p19d100jsn9e6f5d8717cb",
            "accept-encoding": "application/gzip",
            "content-type": "application/x-www-form-urlencoded"
        ]

        settings = ClientSettings(baseHeaders: headers)
        let provider = HTTPProvider(settings: settings, baseURL: baseURL)
        networkManager = ApiClient(provider: provider)
    }

//    MARK: - Translation

    func getTranslation(of text: String, from inLanguage: String, to outLanguage: String, completion: @escaping (_ nativeText: String?, _ translatedText: String?)->()) {

        let bodyParameters = ["source":inLanguage, "q":text, "target":outLanguage]
        let request = Request(path: "/language/translate/v2", httpMethod: .post, task: .requestParameters(bodyParameters: bodyParameters, bodyContentType: .urlEncoded, urlParameters: nil))

        networkManager.execute(request: request) {(response, error) in
            if let response = response {
                print(response.statusCode)
                if let data = response.data {
                    do {
                        let apiResponse = try JSONDecoder().decode(TranslationApiResponse.self, from: data)
                        completion(text, apiResponse.data.translations.first?.translatedText)
                    } catch {
                        print("Can not decode response")
                        completion(text, nil)
                    }
                }
            } else {
                print("error: response is nil")
                completion(text, nil)
            }
        }

    }

//    MARK: - Response decoding

    private func decodeResponse(response: Response)->[Object]? {
        guard let data = response.data else { return nil }
        do {
            let apiResponse = try JSONDecoder().decode(CloudMersiveApiResponse.self, from: data)
            return apiResponse.objects
        } catch {
            print("Can not decode response")
            return nil
        }
    }
}
