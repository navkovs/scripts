#!/bin/bash

# yt - open a youtube video relevant to the given search term
# usage: yt "test" -> plays the first video as if searching "test" in youtube.

wget -q -O "youtubeCode" "https://www.youtube.com/results?search_query=$1"
# videoCode=$(sed -n -e 's/^.*videoI":"//p' youtubeCode | sed -n -e 's/".*$//p')
# videoCode=$(sed -n -E 's/^.*"videoId":"([-0-9a-zA-Z]{10,15})/\1/p' youtubeCode | sed -n -e 's/".*$//p')
videoCode=$(rev youtubeCode | sed -n -E 's/^.*"([-0-9a-zA-Z]{10,15})":"dIoediv"/\1/p' | sed -n -E 's/\{.*$//p' | rev)
videoTitle=$(rev youtubeCode | sed -n -E 's/^.*"lebal"\{:"ataDytilibissecca"\{:"ytilibissecca",\]\}"([-0-9a-zA-Z\.\-\+\\\? ]{10,50})":"txet"\{\[:"snur"\{:"eltit",\}\]\}/\1/p' | sed -n -E 's/404.*$//p' | rev)
echo $videoTitle
# echo 'Code : '$videoCode
echo ''
rm -f youtubeCode
if [[ $2 == n ]] ; then
    youtube-dl -f 'best[height<=1080]' -o - "https://www.youtube.com/watch?v=$videoCode" | tee /tmp/stream.raw | mpv -fs --no-resume-playback --force-seekable=yes -
else
    youtube-dl -f 'best[height<=1080]' -o - "https://www.youtube.com/watch?v=$videoCode" | tee /tmp/stream.raw | mpv -fs --no-resume-playback --start=13% --speed=1.25 --force-seekable=yes -
fi

