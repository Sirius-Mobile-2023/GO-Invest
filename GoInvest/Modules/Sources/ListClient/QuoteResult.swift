import DomainModels
import Foundation

//struct QuoteResult: Decodable {
//    let secid: String?
//    let name: String?
//}

struct QuoteResult: Codable {
 // let secid: String?
  let name: String?
    
  public func toQuote() -> Quote?  {
        return Quote(id: "default", name: name, price: nil)
  }
    
}

//struct QuoteResult : Decodable {
//    let id: [String] = []
//    let name: [String] = []
//
//    enum CodingKeys : CodingKey {
//        case securities
//    }
//    enum SecuritiesCodingKeys : CodingKey {
//        case colums
//        case data
//    }
//
//    enum DataCodingKeys : CodingKey {
//        case secid
//        case name
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        let securitiesContainer = try container.nestedContainer(keyedBy: SecuritiesCodingKeys.self, forKey: .securities)
//
//        let dataContainer = try securitiesContainer.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
//
//        id.append(try dataContainer.decode(String.self, forKey: .secid))
//        name.append(try dataContainer.decode(String.self, forKey: .name))
//    }
//
//
//}
