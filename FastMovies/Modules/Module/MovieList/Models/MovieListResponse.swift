import Foundation
struct MovieListResponse : Codable {
	var page : Int?
	var total_results : Int?
	var total_pages : Int?
	var results : [Movie]?
    
    init(){
        
    }

	enum CodingKeys: String, CodingKey {

		case page = "page"
		case total_results = "total_results"
		case total_pages = "total_pages"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
		total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
		results = try values.decodeIfPresent([Movie].self, forKey: .results)
	}

}
