import Foundation

class NetworkService {
    private var urlComponents: URLComponents
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
            guard let httpResponse = response as? HTTPURLResponse,
                    error == nil && httpResponse.statusCode == 200 else {
                delegate?.showErrorMessage("Возникла ошибка при попытке получения данных. Проверьте интернет соединение.")
                return
            }
            
            if let currentData = data {
                do {
                    let encodeData = try JSONDecoder().decode(TicketsData.self, from: currentData)
                    delegate?.setTicketsData(by: encodeData.data)
                } catch {
                    delegate?.showErrorMessage(error.localizedDescription)
                    return
                }
            }
        }
        
        task.resume()
    }
}



