// AlamofireNetworkService.swift
// Implementation of NetworkService using Alamofire

import Foundation
import Alamofire

final class AlamofireNetworkService: NetworkService {
    private let session: Session
    private let decoder: JSONDecoder
    
    init(session: Session = .default, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: any Endpoint, as type: sending T.Type = T.self) async throws -> T {
        let request = try endpoint.makeRequest()

        let dataTask = session.request(request).validate(statusCode: 200..<300).serializingData()
        let result: Data
        do {
            let response = await dataTask.response
            switch response.result {
            case .success(let data):
                result = data
            case .failure(let error):
                throw NetworkError.transport(error.localizedDescription)
            }
            if let statusCode = response.response?.statusCode, !(200..<300).contains(statusCode) {
                throw NetworkError.unacceptableStatusCode(statusCode)
            }
        } catch {
            throw NetworkError.transport(error.localizedDescription)
        }
        
        do {
            return try decoder.decode(T.self, from: result)
        } catch {
            throw NetworkError.decoding(String(describing: error))
        }
    }
}
