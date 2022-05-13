//
//  PlatformTextView.h
//  Runner
//
//  Created by Story5 on 2022/5/14.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlatformTextView : NSObject<FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args;

@end

NS_ASSUME_NONNULL_END
