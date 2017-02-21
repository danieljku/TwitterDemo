# Project 4 - TwitterDemo

TwitterDemo is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 11 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] User can pull to refresh.

The following **additional** features are implemented:

- [X] Detail for the tweet can be seen through clicking on the cell.
- [X] Any tweet that was retweeted will be indicated above the username.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Post request
2. Tap Gesture

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/wE1Ieoe.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Understanding how to do post requests were difficult.
- Decrementing retweet was confusing since understanding how to check the flag was hard to figure out.

## License

    Copyright [2017] [Daniel Ku]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.