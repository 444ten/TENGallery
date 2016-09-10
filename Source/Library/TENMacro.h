//
//  TENMacro.h
//  444tenIOS
//
//  Created by Andrey Ten on 6/18/15.
//  Copyright (c) 2015 Andrey Ten. All rights reserved.
//

#define TENDefineBaseViewProperty(propertyName, viewClass)  \
    @property (nonatomic, readonly) viewClass *propertyName;

#define TENBaseViewGetterSynthesize(selector, viewClass)                            \
    - (viewClass *)selector {                                                       \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) {   \
            return (viewClass *)self.view;                                          \
        }                                                                           \
                                                                                    \
        return nil;                                                                 \
    }

#define TENViewControllerBaseViewProperty(baseViewController, propertyName, baseViewClass)  \
    @interface baseViewController (__##baseViewController##BaseView)                        \
    TENDefineBaseViewProperty(propertyName, baseViewClass)                                  \
                                                                                            \
    @end                                                                                    \
                                                                                            \
    @implementation baseViewController (__##baseViewController##BaseView) \
    \
    @dynamic propertyName; \
    \
    TENBaseViewGetterSynthesize(propertyName, baseViewClass); \
    \
    @end

#define TENWeakify(variable) \
    __weak __typeof(variable) __TENWeakified_##variable = variable;

// you should only call this method after you called weakify for that same variable
#define TENStrongify(variable) \
    _Pragma ("clang diagnostic push"); \
    _Pragma ("clang diagnostic ignored \"-Wshadow\""); \
    \
    __strong __typeof(variable) variable = __TENWeakified_##variable; \
    \
    _Pragma ("clang diagnostic pop");

#define TENEmptyResult

#define TENStrongifyAndReturnIfNil(variable) \
    TENStrongifyAndReturnResultIfNil(variable, TENEmptyResult)

#define TENStrongifyAndReturnNilIfNil(variable) \
    TENStrongifyAndReturnResultIfNil(variable, nil)

#define TENStrongifyAndReturnResultIfNil(variable, result) \
    TENStrongify(variable) \
    if (!variable) { \
        return result; \
    }

#define TENObserverSetter(propertyName)         \
    if (_##propertyName != propertyName) {      \
        [_##propertyName removeObserver:self];  \
                                                \
        _##propertyName = propertyName;         \
        [propertyName addObserver:self];        \
    }

#define TENSaveToUserDefaults(className)                                                                    \
NSData *encoded##className = [NSKeyedArchiver archivedDataWithRootObject:[className sharedInstance]];       \
[[NSUserDefaults standardUserDefaults] setObject:encoded##className forKey:@"k"#className"UserDefaultsKey"];

#define TENRestoreFromUserDefaults(className)                                                                       \
NSData *decoded##className = [[NSUserDefaults standardUserDefaults] objectForKey:@"k"#className"UserDefaultsKey"];  \
[NSKeyedUnarchiver unarchiveObjectWithData:decoded##className];

#define TENClearUserDefaults(className)                                                     \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"k"#className"UserDefaultsKey"];

#define PDTKeyForNSCoding(propertyName) \
@"kTEN"#propertyName"NSCodingKey"
