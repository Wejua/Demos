//
//  DataManager.m
//  weijie.stock
//
//  Created by 周位杰 on 2021/12/13.
//

#import "DataManager.h"
#import <sqlite3.h>

@implementation DataManager

+ (NSString *)path {
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArr firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/stock.db",documentPath];
    return path;
}


char *error;

//    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
const char *createSQL = "create table if not exists list(id integer primary key autoincrement,name char,sex char)";

int tableResult = sqlite3_exec(database, createSQL, NULL, NULL, &error);

if (tableResult != SQLITE_OK) {

   NSLog(@"创建表失败:%s",error);
}


sqlite3 *database;
int databaseResult = sqlite3_open([[self path] UTF8String], &database);
if (databaseResult != SQLITE_OK) {
    NSLog(@"创建／打开数据库失败,%d",databaseResult);
}

#pragma mark - Singleton
static DataManager *_instance = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    });
    return _instance ;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [DataManager shareInstance] ;
}

- (id) copyWithZone:(struct _NSZone *)zone {
    return [DataManager shareInstance] ;
}

@end
