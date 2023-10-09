//
//  AppDelegate.h
//  textureDemo
//
//  Created by jieyi lu on 2018/3/23.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

