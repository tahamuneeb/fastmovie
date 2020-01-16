import Foundation
import CoreData

// Movie Model with core data managed object support

class Movie : NSManagedObject, Codable {
	@NSManaged var popularity : NSNumber?
	@NSManaged var id : NSNumber?
	@NSManaged var video : NSNumber?
	@NSManaged var vote_count : NSNumber?
	@NSManaged var vote_average : NSNumber?
	@NSManaged var title : String?
	@NSManaged var release_date : String?
	@NSManaged var original_language : String?
	@NSManaged var original_title : String?
	@NSManaged var backdrop_path : String?
	@NSManaged var adult : NSNumber?
	@NSManaged var overview : String?
	@NSManaged var poster_path : String?
    @NSManaged var type : String?

	enum CodingKeys: String, CodingKey {

		case popularity = "popularity"
		case id = "id"
		case video = "video"
		case vote_count = "vote_count"
		case vote_average = "vote_average"
		case title = "title"
		case release_date = "release_date"
		case original_language = "original_language"
		case original_title = "original_title"
		case backdrop_path = "backdrop_path"
		case adult = "adult"
		case overview = "overview"
		case poster_path = "poster_path"
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
		id = try  NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .id) ?? 0)
		video = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .video) ?? false)
		vote_count = try NSNumber.init(value: values.decodeIfPresent(Int.self, forKey: .vote_count) ?? 0)
		vote_average = try NSNumber.init(value: values.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		adult = try NSNumber.init(value: values.decodeIfPresent(Bool.self, forKey: .adult) ?? false)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        type = try values.decodeIfPresent(String.self, forKey: .type)
	}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(popularity?.intValue, forKey: .popularity)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(video?.boolValue, forKey: .video)
        try container.encode(vote_count?.intValue, forKey: .vote_count)
        try container.encode(vote_average?.doubleValue, forKey: .vote_average)
        try container.encode(title, forKey: .title)
        try container.encode(release_date, forKey: .release_date)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(adult?.boolValue, forKey: .adult)
        try container.encode(overview, forKey: .overview)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(type, forKey: .type)
    }
    
    public func setType(type:MovieType){
        self.type = type.rawValue
    }

}
