//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/4/24.
//

import Foundation

enum NetworkError : Error {
    case networkingError
    case dataError
    case parseError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    typealias NetworkCompletion = ((Result<[Music], NetworkError>) -> Void)
    
    
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion){
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let musics = self.parseJSON(safeData) {
                print("Parcing 성공")
                completion(.success(musics))
            } else {
                print("Parcing 실패")
                completion(.failure(.parseError))
            }
        }
        
        task.resume()
    }
    
    private func parseJSON(_ musicData: Data) -> [Music]? {
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
    





