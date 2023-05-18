//
//  APICaller.swift
//  Dogecoin
//
//  Created by Nazar Kopeyka on 22.04.2023.
//

import Foundation

final class APICaller { /* 1 */
    static let shared = APICaller() /* 2 */
    
    private init() {} /* 3 */
    
    struct Constants { /* 4 */
        static let apikey = "794617d4-43a1-40c0-8900-eb070bbb2700" /* 5 */
        static let apikeyHeader = "X-CMC_PRO_API_KEY" /* 6 */
        static let baseUrl = "https://pro-api.coinmarketcap.com/v1/" /* 7 */
        static let doge = "dogecoin" /* 9 */
        static let endpoint = "cryptocurrency/quotes/latest" /* 8 */
    }
    
    enum APIError: Error { /* 46 */
        case invalidUrl /* 47 */
    }
    
    public func getDogeCoinData(
        completion: @escaping (Result<DogeCoinData, Error>) -> Void
    ) { /* 41 */
        guard let url = URL(string: Constants.baseUrl + Constants.endpoint + "?slug=" + Constants.doge) else { /* 43 */
            completion(.failure(APIError.invalidUrl)) /* 44 */
            return /* 45 */
        }
        
        print("\n\n API URL: \(url.absoluteString) \n\n") /* 62 */
        
        var request = URLRequest(url: url) /* 48 */
        request.setValue(Constants.apikey, forHTTPHeaderField: Constants.apikeyHeader) /* 49 */
        request.httpMethod = "GET" /* 50 */
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in /* 51 */
            if let error = error { /* 52 */
                completion(.failure(error)) /* 53 */
                return /* 54 */
            }
            
            guard let data = data else { /* 55 */
                return /* 56 */
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data) /* 57 */ /* 66 change DogeCoinData */
//                print("\n\n API Result: \(response) \n\n") /* 70 */
                guard let dogeCoinData = response.data.values.first else { /* 67 */
                    return /* 68 */
                }
                completion(.success(dogeCoinData)) /* 58 */ /* 69 change result*/
            }
            catch { /* 59 */
                completion(.failure(error)) /* 60 */
                
            }
        }
        
        task.resume() /* 61 */
    }
}
