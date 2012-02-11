#import "PFMLocation.h"
#import "Application.h"

@implementation PFMLocation

@synthesize
  id=_id
, weatherConditions=_weatherConditions
, cloudCover=_cloudCover
, windSpeed=_windSpeed
, dewPoint=_dewPoint
, temperature=_temperature
, windDirection=_windDirection
, elevation=_elevation
, longitude=_longitude
, latitude=_latitude
, accuracy=_accuracy
, countryName=_countryName
, country=_country
, city=_city;

+ (PFMLocation *)locationFrom:(NSDictionary *)locationDict {
  PFMLocation * location = [PFMLocation new];

  NSDictionary * weatherDict = (NSDictionary *)$safe([locationDict $for:@"weather"]);
  NSDictionary * locationDetailsDict = (NSDictionary *)$safe([locationDict $for:@"location"]);

  location.id = $safe([locationDict $for:@"id"]);

  if (weatherDict != nil) {
    location.weatherConditions = $safe([weatherDict $for:@"conditions"]);
    location.cloudCover = $safe([weatherDict $for:@"cloud_cover"]);
    location.windSpeed = $safe([weatherDict $for:@"wind_speed"]);
    location.windDirection = $safe([weatherDict $for:@"wind_direction"]);
    location.dewPoint = $safe([weatherDict $for:@"dewpoint"]);
    location.temperature = $safe([weatherDict $for:@"temperature"]);
  }

  if (location != nil) {
    location.elevation = [(NSNumber *)$safe([locationDetailsDict $for:@"elevation"]) doubleValue];
    location.accuracy = [(NSNumber *)$safe([locationDetailsDict $for:@"accuracy"]) doubleValue];
    location.countryName = $safe([locationDetailsDict $for:@"country_name"]);
    location.country = $safe([locationDetailsDict $for:@"country"]);
    location.city = $safe([locationDetailsDict $for:@"city"]);
  }

  location.latitude = [(NSNumber *)$safe([locationDict $for:@"lat"]) doubleValue];
  location.longitude = [(NSNumber *)$safe([locationDict $for:@"lng"]) doubleValue];

  return location;
}

@end
