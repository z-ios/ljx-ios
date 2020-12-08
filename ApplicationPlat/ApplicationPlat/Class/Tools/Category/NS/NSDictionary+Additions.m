//
//  NSDictionary+Additions.m
//  FamiliarStranger
//
//  Created by admin on 15/12/22.
//
//

#import "NSDictionary+Additions.h"
#import "NSObject+Additions.h"
@implementation NSDictionary (Additions)

+(NSDictionary*)loadPlistFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    return [NSDictionary  dictionaryWithContentsOfFile:path];
}

-(id)parseForKey:(id)aKey
{
    id object = [self objectForKey:@"aKey"];
    if (!object) {
        return [NSObject new];
    }
    return object;
}

-(BOOL)safeBoolForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedBool]:NO;
}
-(id)safeObjectForKey:(NSString*)aKey
{
    return [[self objectForKey:aKey] expectedObject];
}
-(NSString*)safeStringForKey:(NSString*)aKey
{
    return [self objectForKey:aKey] ? [[self objectForKey:aKey] expectedString] : @"";
}

-(NSArray*)safeArrayForKey:(NSString*)aKey
{
    return [self objectForKey:aKey] ? [[self objectForKey:aKey] expectedArray] : @[];
}

-(NSDictionary*)safeDictionaryForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedDictionary]:@{};
}
-(NSInteger)safeIntegerForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedInteger]:0;
}
-(long long)safeLonglongForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedLonglong]:0;
}
-(float)safeFloatForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedFloat]:0.0f;
}
-(double)safeDoubleForKey:(NSString*)aKey
{
    return [self objectForKey:aKey]?[[self objectForKey:aKey] expectedDouble]:0.0f;
}

//+ (NSDictionary *)jwtDecodeWithJwtString:(NSString *)jwtStr{
//
//    NSArray * segments = [jwtStr componentsSeparatedByString:@"."];
//    NSString * base64String = [segments objectAtIndex:1];
//
//    int requiredLength = (int)(4 *ceil((float)[base64String length]/4.0));
//    int nbrPaddings = requiredLength - (int)[base64String length];
//    if(nbrPaddings > 0){
//        NSString * pading = [[NSString string] stringByPaddingToLength:nbrPaddings withString:@"=" startingAtIndex:0];
//        base64String = [base64String stringByAppendingString:pading];
//    }
//    base64String = [base64String stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
//    base64String = [base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
//    NSData * decodeData = [[NSData alloc] initWithBase64EncodedData:base64String options:0];
//    NSData * decodeData = [[NSData alloc] initWithBase64EncodedData:<#(nonnull NSData *)#> options:<#(NSDataBase64DecodingOptions)#>];
//
//    NSString * decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
//    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[decodeString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//    return jsonDict;
//}

@end
