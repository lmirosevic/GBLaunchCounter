# GBLaunchCounter ![Version](https://img.shields.io/cocoapods/v/GBLaunchCounter.svg?style=flat)&nbsp;![License](https://img.shields.io/badge/license-Apache_2-green.svg?style=flat)

Count how many times your iOS or Mac OS X app has been launched, and optionally register blocks for when a certain number of launches has occurred.

Usage
------------

Depending on your definition of a `launch` you can put this either in `application:didFinishLaunching:withOptions:` (iOS)/`-applicationDidFinishLaunching:` (OS X), or in ` applicationDidBecomeActive:` (same name on iOS and OS X, but beware different parameters):

```objective-c
[GBLaunchCounter track];
```

You can see how many times your app has launched using:

```objective-c
[GBLaunchCounter launchCount];			//Returns a NSUInteger
```

You can optionally register a block to be called for when you app has reached a certain number of launches:

```objective-c
[self callHandler:^(NSUInteger launchCount) {
    NSLog(@"This is launch number 10");
} onLaunchNumber:10];
```

...or every n number of launches:

```objective-c
[self callHandler:^(NSUInteger launchCount) {
    NSLog(@"Logging every third launch");
} everyNLaunches:3];
```

Don't forget to import static library header (on iOS):

```objective-c
#import "GBLaunchCounter.h" 					//iOS
```

...or framework header (on OS X):

```objective-c
#import <GBLaunchCounter/GBLaunchCounter.h> 	//OS X
```

Dependencies
------------

* [GBToolbox](https://github.com/lmirosevic/GBToolbox)
* [GBStorageController](https://github.com/lmirosevic/GBStorageController)

iOS: Add to your project's workspace, add dependency for GBLaunchCounter-iOS, link with your binary, add -ObjC linker flag, add header search path.

OS X: Add to your project's workspace, add dependency for GBLaunchCounter-OSX, link with your binary, add "copy file" step to copy framework into bundle.

Copyright & License
------------

Copyright 2013 Luka Mirosevic

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/lmirosevic/gblaunchcounter/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
