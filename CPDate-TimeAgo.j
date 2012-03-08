/*
 * CPDate-TimeAgo.j
 *
 * Cappuccino adaptation of jQuery's timeago by Ryan McGeary.
 *
 * Created by Alexander Ljungberg on May 17, 2010.
 * Copyright 2010-12, WireLoad Inc. All rights reserved.
 *
 * All rights reserved.
 *
 * jQuery's TimeAgo is released under the MIT license.
 * Copyright (c) 2008-2010, Ryan McGeary (ryanonjavascript -[at]- mcgeary [*dot*] org)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

var TimeAgoSettings =
    {
        refreshMillis: 60000,
        allowFuture: false,
        strings:
        {
            prefixAgo: null,
            prefixFromNow: null,
            suffixAgo: "ago",
            suffixFromNow: "from now",
            seconds: "less than a minute",
            minute: "about a minute",
            minutes: "%d minutes",
            hour: "about an hour",
            hours: "about %d hours",
            day: "a day",
            days: "%d days",
            month: "about a month",
            months: "%d months",
            year: "about a year",
            years: "%d years"
        }
    };

var distance = function(date)
{
    return (new Date().getTime() - date.getTime());
}

var substitute = function(string, value)
{
    return string.replace(new RegExp("%d", "i"), value);
}

@implementation CPDate (TimeAgo)

- (CPString)timeAgo
{
    var distanceMillis = distance(self),
        l = TimeAgoSettings.strings,
        prefix = l.prefixAgo,
        suffix = l.suffixAgo || l.ago;

    if (TimeAgoSettings.allowFuture)
    {
        if (distanceMillis < 0)
        {
            prefix = l.prefixFromNow;
            suffix = l.suffixFromNow || l.fromNow;
        }
        distanceMillis = Math.abs(distanceMillis);
    }

    var seconds = distanceMillis / 1000,
        minutes = seconds / 60,
        hours = minutes / 60,
        days = hours / 24,
        years = days / 365,
        words = seconds < 45 && substitute(l.seconds, Math.round(seconds)) ||
            seconds < 90 && substitute(l.minute, 1) ||
            minutes < 45 && substitute(l.minutes, Math.round(minutes)) ||
            minutes < 90 && substitute(l.hour, 1) ||
            hours < 24 && substitute(l.hours, Math.round(hours)) ||
            hours < 48 && substitute(l.day, 1) ||
            days < 30 && substitute(l.days, Math.floor(days)) ||
            days < 60 && substitute(l.month, 1) ||
            days < 365 && substitute(l.months, Math.floor(days / 30)) ||
            years < 2 && substitute(l.year, 1) ||
            substitute(l.years, Math.floor(years));

    return [[prefix, words, suffix].join(" ") stringByTrimmingWhitespace];
}

@end

@implementation TimeAgoTransformer : CPValueTransformer

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

+ (Class)transformedValueClass
{
    return [CPString class];
}

- (id)transformedValue:(id)value
{
    return [value timeAgo];
}

@end
