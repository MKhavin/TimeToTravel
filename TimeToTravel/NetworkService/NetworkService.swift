import Foundation

class NetworkService {
    var urlComponents: URLComponents
    weak var delegate: DataTaskResponder?

    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "travel.wildberries.ru"
        urlComponents.path = "/statistics/v1/cheap"
    }
    
    func getTicketsData() {
        guard let url = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [unowned self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, error == nil && httpResponse.statusCode == 200 else {
                //ToDo: UIAlert with error
                return
            }
            
            if let currentData = data {
                do {
                    let encodeData = try JSONDecoder().decode(TicketsData.self, from: currentData)
                    self.delegate?.setTicketsData(by: encodeData.data)
                } catch {
                    //ToDo: UIAlert with error
                    return
                }
            }
        }
        
        task.resume()
    }
}



