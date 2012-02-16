Cappuccino TimeAgo
==================

Convert dates to strings such as "14 minutes ago".
--------------------------------------------------

This Cappuccino framework adds a `CPDate` category which turns a date into a relative time description in English such as "3 seconds" or "1 year". It's a port of jQuery's timeago plugin.

To use:

    @import <cappuccino-timeago/CPDate-TimeAgo.j>

    @implementation Test : CPObject
    {

    }

    - (CPString)description
    {
        // "12020 years"
        return [[CPDate distantPast] timeAgo];
    }

    @end

There is also a handy bindings transformer.

    var bindingOptions = [CPDictionary dictionaryWithObject:[TimeAgoTransformer new] forKey:CPValueTransformerBindingOption];
    [dateLabel bind:CPValueBinding toObject:theThing withKeyPath:@"createdAt" options:bindingOptions];

## Installation ##

Add the repository to your app's Frameworks folder.

Example:

    git submodule add <path to this repo> Frameworks/cappuccino-timeago
    git submodule init
    git submodule update

## License ##

Free to use and modify under the terms of the MIT open source license.
