//
//	 ______    ______    ______    
//	/\  __ \  /\  ___\  /\  ___\   
//	\ \  __<  \ \  __\_ \ \  __\_ 
//	 \ \_____\ \ \_____\ \ \_____\ 
//	  \/_____/  \/_____/  \/_____/ 
//
//	Copyright (c) 2012 BEE creators
//	http://www.whatsbug.com
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//
//
//  NSObject+BeeDatabase.h
//

#import "Bee_Precompile.h"
#import "Bee_Database.h"
#import "NSObject+BeeDatabase.h"

#pragma mark -

@implementation NSObject(BeeDatabase)

+ (BeeDatabase *)DB
{
	BeeDatabase * db = [BeeDatabase sharedDatabase];
	if ( nil == db )
	{
		NSBundle * bundle = [NSBundle mainBundle];
		NSString * bundleName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
		if ( bundleName )
		{
			NSString * dbName = [NSString stringWithFormat:@"%@.db", bundleName];
			BOOL succeed = [BeeDatabase openSharedDatabase:dbName];
			if ( succeed )
			{
				db = [BeeDatabase sharedDatabase];
			}
		}

		if ( db )
		{
			[db clearState];	
		}
	}
	return db;
}

- (BeeDatabase *)DB
{
	return [NSObject DB];
}

- (NSString *)tableName
{
	return [[self class] tableName];
}

+ (NSString *)tableName
{
	return [BeeDatabase tableNameForClass:self];
}

@end
