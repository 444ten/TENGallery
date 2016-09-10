//
//  TENModel.h
//  444tenFB
//
//  Created by Andrey Ten on 7/22/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENObservableObject.h"

typedef NS_ENUM(NSUInteger, TENModelState) {
    TENModelUnloaded,
    TENModelWillLoad,
    TENModelLoaded,
    TENModelDidFailLoad,
    TENModelChanged
};

@protocol TENModelObserver

@optional
- (void)modelDidUnload:(id)model;
- (void)modelWillLoad:(id)model;
- (void)modelDidLoad:(id)model;
- (void)modelDidFailLoad:(id)model;
- (void)model:(id)model didChangeWithUsersInfo:(id)userInfo;

@end

@interface TENModel : TENObservableObject

- (void)load;

// This method's is intended for subclassing. Never call it's directly.
- (void)setupLoading;

// This method is intended for subclassing. Never call it directly.
// You should set state
- (void)performLoadingInBackground;

@end
