import Foundation

let data = """
{
"links":{
"next":"http://www.neowsapp.com/rest/v1/feed?start_date=2020-03-22&end_date=2020-03-29&detailed=false&api_key=cmPeNpKaH2oeNUfqFhfnWenrwMk6fBe3q9E09fSu",
"prev":"http://www.neowsapp.com/rest/v1/feed?start_date=2020-03-08&end_date=2020-03-15&detailed=false&api_key=cmPeNpKaH2oeNUfqFhfnWenrwMk6fBe3q9E09fSu",
"self":"http://www.neowsapp.com/rest/v1/feed?start_date=2020-03-15&end_date=2020-03-22&detailed=false&api_key=cmPeNpKaH2oeNUfqFhfnWenrwMk6fBe3q9E09fSu"
},
"element_count":52,
"near_earth_objects":{
"2020-03-22":[
{
"links":{
"self":"http://www.neowsapp.com/rest/v1/neo/54013533?api_key=cmPeNpKaH2oeNUfqFhfnWenrwMk6fBe3q9E09fSu"
},
"id":"54013533",
"neo_reference_id":"54013533",
"name":"(2020 DC5)",
"nasa_jpl_url":"http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=54013533",
"absolute_magnitude_h":23.185,
"estimated_diameter":{
"kilometers":{
"estimated_diameter_min":0.0613133403,
"estimated_diameter_max":0.1371007968
},
"meters":{
"estimated_diameter_min":61.3133402762,
"estimated_diameter_max":137.1007967851
},
"miles":{
"estimated_diameter_min":0.0380983316,
"estimated_diameter_max":0.0851904592
},
"feet":{
"estimated_diameter_min":201.1592593117,
"estimated_diameter_max":449.8057781245
}
},
"is_potentially_hazardous_asteroid":false,
"close_approach_data":[
{
"close_approach_date":"2020-03-22",
"close_approach_date_full":"2020-Mar-22 09:19",
"epoch_date_close_approach":1584868740000,
"relative_velocity":{
"kilometers_per_second":"13.4173568872",
"kilometers_per_hour":"48302.4847938466",
"miles_per_hour":"30013.285620932"
},
"miss_distance":{
"astronomical":"0.3211380647",
"lunar":"124.9227071683",
"kilometers":"48041570.455042189",
"miles":"29851647.6414686482"
},
"orbiting_body":"Earth"
}
],
"is_sentry_object":false
}]}}
""".data(using: .utf8)!

struct RelativeVelocity: Codable {
    let kmPerSecond: String
    let kmPerHour: String
    let milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kmPerSecond = "kilometers_per_second"
        case kmPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
}

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String
    let epochDateCloseApproach: Int64
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

struct Asteriod: Codable {
    let id: String
    let name: String
    let neoReferenceId: String
    let nasaJPLUrl: String
    let absoluteMagnitude: Double
    let estimatedDiameter: [String: [String:Double]]
    let isPotentiallyHazardousAsteriod: Bool
    let closeApproachData: [CloseApproachData]
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case neoReferenceId = "neo_reference_id"
        case nasaJPLUrl = "nasa_jpl_url"
        case absoluteMagnitude = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteriod = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

struct Links: Codable {
    let prev: String
    let next: String
    let current: String
    
    enum CodingKeys: String, CodingKey {
        case prev
        case next
        case current = "self"
    }
}

struct Asteriods: Codable {
    let links: Links
    let elementCount: Int
    let nearEarthObjects: [String: [Asteriod]]
    
    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

do {
    let asteriods = try JSONDecoder().decode(Asteriods.self, from: data) as Asteriods
    print(asteriods.elementCount)
    print(asteriods.nearEarthObjects.first?.value[0].id)
    print(asteriods.nearEarthObjects.first?.value[0].closeApproachData)
} catch {
    print(error)
}
