GBLaunchCounter
============

Count how many times your iOS or Mac OS X app has been launched, and optionally register handlers for when a certain number of launches has occurred.

Usage
------------

Depending on your definition of a `launch` you can put this either in `application:didFinishLaunching:withOptions:` (iOS)/`-applicationDidFinishLaunching:` (OS X), or in ` applicationDidBecomeActive:` (same name on iOS and OS X, but beware different paramters):

```objective-c
[GBLaunchCounter appLaunched];
```

You can see how many times your app has launched using:

```objective-c
[GBLaunchCounter launchCount];			//Returns a NSUInteger
```

You can optionally register a handler for when you app has reached a certain number of launches:

...todo

Then call these whenever you want (in these examples the user has launched a bunch of previous versions, and this is the first time he's launched version 3.0):

```objective-c
[GBVersionTracking isFirstLaunchEver];				//Returns: NO
[GBVersionTracking isFirstLaunchForVersion];		//Returns: YES
[GBVersionTracking isFirstLaunchForBuild];			//Returns: YES
 
[GBVersionTracking currentVersion];					//Returns: @"3.0"
[GBVersionTracking previousVersion];				//Returns: @"2.1"
[GBVersionTracking versionHistory];					//Returns: [@"1.0", @"2.0", @"2.1", @"3.0"]
 
[GBVersionTracking currentBuild];					//Returns: @"3000"
[GBVersionTracking previousBuild];					//Returns: @"2102"
[GBVersionTracking buildHistory];					//Returns: [@"1000", @"2043", @"2107", @"3004"]
 ```

N.B.: The build and version numbers are whatever you define in your app's Info.plist

Don't forget to import static library header (on iOS):

```objective-c
#import "GBVersionTracking.h" 						//iOS
```

...or framework header (on OS X):

```objective-c
#import <GBVersionTracking/GBVersionTracking.h> 	//OS X
```

Dependencies
------------

* [GBToolbox](https://github.com/lmirosevic/GBToolbox)

iOS: Add to your project's workspace, add dependency for GBVersionTracking-iOS, link with your binary, add -ObjC linker flag, add header search path.

OS X: Add to your project's workspace, add dependency for GBVersionTracking-OSX, link with your binary, add "copy file" step to copy framework into bundle.

Copyright & License
------------

Copyright 2013 Luka Mirosevic

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.