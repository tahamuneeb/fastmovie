import Foundation
import CoreData

// Movie Model with core data managed object support

class Movie: NSManagedObject, Codable {
	@NSManaged var popularity: NSNumber?
	@NSManaged var movieID: NSNumber?
	@NSManaged var video: NSNumber?
	@NSManaged var voteCount: NSNumber?
	@NSManaged var voteAverage: NSNumber?
	@NSManaged var title: String?
	@NSManaged var releaseDate: String?
	@NSManaged var originalLanguage: String?
	@NSManaged var originalTitle: String?
	@NSManaged var backdropPath: String?
	@NSManaged var adult: NSNumber?
	@NSManaged var overview: String?
	@NSManaged var posterPath: String?
    @NSManaged var type: String?

	enum CodingKeys: String, CodingKey {

		case popularity = "popularity"
		case movieID = "id"
		case video = "video"
		case voteCount = "vote_count"
		case voteAverage = "vote_average"
		case title = "title"
		case releaseDate = "release_date"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case backdropPath = "backdrop_path"
		case adult = "adult"
		case overview = "overview"
		case posterPath = "poster_path"
        case type = "type"
	}

    required convenience init(from decoder: Decoder) throws {

        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
            fatalError("Failed to decode Movie")
        }
        self.init(entity: entity, insertInto: managedObjectContext)

		let values = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try NSNumber.init(value: values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0)
		movieID = try  NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .movieID) ?? 0)
		video = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .video) ?? false)
		voteCount = try NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0)
		voteAverage = try NSNumber.init(value: values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
		originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
		backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
		adult = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .adult) ?? false)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        type = try values.decodeIfPresent(String.self, forKey: .type)
	}

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(popularity?.intValue, forKey: .popularity)
        try container.encode(movieID?.intValue, forKey: .movieID)
        try container.encode(video?.boolValue, forKey: .video)
        try container.encode(voteCount?.intValue, forKey: .voteCount)
        try container.encode(voteAverage?.doubleValue, forKey: .voteAverage)
        try container.encode(title, forKey: .title)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(adult?.boolValue, forKey: .adult)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(type, forKey: .type)
    }

    public func setType(type: MovieType) {
        self.type = type.rawValue
    }

}
