/*
 * CPDate-TimeAgoTest.j
 *
 * Created by Alexander Ljungberg on May 17, 2010.
 * Copyright 2010-12, WireLoad Inc. All rights reserved.
 *
 * All rights reserved.
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

@import "CPDate-TimeAgo.j"

@implementation CPDateTimeAgoTest : OJTestCase
{
}

- (void)testTimeAgo
{
    [self assert:"less than a minute ago" equals:[[CPDate date] timeAgo]];
    [self assert:"about a minute ago" equals:[[CPDate dateWithTimeIntervalSinceNow:-60] timeAgo]];
    [self assert:"2 minutes ago" equals:[[CPDate dateWithTimeIntervalSinceNow:-90] timeAgo]];
    [self assert:"about a month ago" equals:[[CPDate dateWithTimeIntervalSinceNow:(-3600 * 24 * 30)] timeAgo]];
}

- (void)testTimeInFuture
{
    [self assert:"less than a minute ago" equals:[[CPDate date] timeAgoWithFuture:YES]];
    [self assert:"about a minute from now" equals:[[CPDate dateWithTimeIntervalSinceNow:+60] timeAgoWithFuture:YES]];
    [self assert:"2 minutes from now" equals:[[CPDate dateWithTimeIntervalSinceNow:+90] timeAgoWithFuture:YES]];
    [self assert:"about a month from now" equals:[[CPDate dateWithTimeIntervalSinceNow:(3600 * 24 * 30)] timeAgoWithFuture:YES]];
}

@end
