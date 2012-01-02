//
//  ICB_WeatherConditions.h
//  LocalWeather
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

@interface ICB_WeatherConditions : NSObject {
    NSString *condition, *location;
    NSURL *conditionImageURL;
    NSInteger currentTemp,lowTemp,highTemp;
}

@property (nonatomic,retain) NSString *condition, *location;
@property (nonatomic,retain) NSURL *conditionImageURL;
@property (nonatomic) NSInteger currentTemp, lowTemp, highTemp;

- (ICB_WeatherConditions *)initWithQuery:(NSString *)query;

@end