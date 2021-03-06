//
//  Business.m
//  Yelp
//
//  Created by Kenny Chu on 2015/6/22.
//  Copyright (c) 2015年 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        }];
        self.categories = [categoryNames componentsJoinedByString:@", "];
        self.name = dictionary[@"name"];
        self.imgUrl = dictionary[@"image_url"];
        NSString *locAddr;
        NSArray *addrArr = [dictionary valueForKeyPath:@"location.address"];
        if (addrArr.count > 0) {
            locAddr = addrArr[0];
        } else {
            locAddr = @"";
        }
        NSString *locNbr = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        NSString *street = (locAddr !=  nil) ? locAddr : @"";
        NSString *neighborhood = (locNbr != nil) ? locNbr : @"";
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];
        self.numReviews = [dictionary[@"review_count"] integerValue];
        self.ratingImgUrl = dictionary[@"rating_img_url"];
        float milesPerMeter = 0.000621371;
        self.distance = [dictionary[@"distance"] integerValue] * milesPerMeter;
    }
    
    
    return self;
}

+ (NSArray *)businessWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        
        [businesses addObject:business];
    }
    return businesses;
}

@end
