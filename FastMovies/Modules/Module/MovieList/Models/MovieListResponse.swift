import Foundation
struct MovieListResponse: Codable {
	var page: Int?
	var totalResults: Int?
	var totalPages: Int?
	var results: [Movie]?

    init() {

    }

	enum CodingKeys: String, CodingKey {

		case page = "page"
		case totalResults = "totalResults"
		case totalPages = "total_pages"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		results = try values.decodeIfPresent([Movie].self, forKey: .results)
	}

}
