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
        do {
            popularity = try NSNumber.init(value: values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0)
        } catch {
            popularity = NSNumber.init(value: 0)
        }
        do {
            movieID = try NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .movieID) ?? 0)
        } catch {
            movieID = NSNumber.init(value: 0)
        }
        do {
            video = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .video) ?? false)
        } catch {
            video = NSNumber.init(value: false)
        }
        do {
            voteCount = try NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0)
        } catch {
            voteCount =  NSNumber.init(value: 0)
        }
		do {
            voteAverage = try NSNumber.init(value: values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0)
        } catch {
            voteAverage =  NSNumber.init(value: 0)
        }
		do {
            title = try values.decodeIfPresent(String.self, forKey: .title)
        } catch {
            title =  ""
        }
		do {
            releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        } catch {
            releaseDate =  ""
        }
        do {
            originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        } catch {
            originalLanguage =  ""
        }
		do {
            originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        } catch {
            originalTitle =  ""
        }
		do {
            backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        } catch {
            backdropPath =  ""
        }
		do {
            adult = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .adult) ?? false)
        } catch {
            adult = NSNumber.init(value: false)
        }
		do {
            overview = try values.decodeIfPresent(String.self, forKey: .overview)
        } catch {
            overview =  ""
        }
		do {
            posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        } catch {
            posterPath =  ""
        }
		do {
            type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        } catch {
            type =  ""
        }
	}

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(popularity?.doubleValue, forKey: .popularity)
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
