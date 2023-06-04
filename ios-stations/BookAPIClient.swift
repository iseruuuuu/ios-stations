//
//  BookAPIClient.swift
//  ios-stations
//

import Alamofire
import Foundation


protocol BookAPIClientProtocol {
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void)
}

class BookAPIClient: BookAPIClientProtocol {
    func fetchBooks(offset: Int, completion: @escaping ([Book]?) -> Void) {
        let urlString = "https://ifrbzeaz2b.execute-api.ap-northeast-1.amazonaws.com/public/books?offset=\(offset)"
        //Alamofireを使用して、APIエンドポイントへのHTTPリクエストを送信する。
        AF.request(urlString).responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            do {
                //JSONDecoderを使用して、データをBookResponce型にデコードする。
                let decoder = JSONDecoder()
                let booksResponse = try decoder.decode(BooksResponse.self, from: data)
                completion(booksResponse.books)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
    }
}
