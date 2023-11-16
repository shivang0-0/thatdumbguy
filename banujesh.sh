#!/bin/sh

# vars
VOSK_MODEL_PATH="$HOME/projects/thatdumbguy/vosk-model-small-en-in-0.4"
VID="https://vid.puffyan.us"

# mic input
ffmpeg -y -f alsa -i default -acodec pcm_s16le -ac 1 -ar 44100 -t 5 -f wav ~/.cache/sample.wav

# convert audio to txt
vosk-transcriber -m $VOSK_MODEL_PATH -i ~/.cache/sample.wav -o ~/.cache/conv.txt
read audio_input < ~/.cache/conv.txt

# audio confirm notify
google_speech "All right... let me play.. $audio_input" &

# make youtube search query
query="$(printf '%s' "song audio $audio_input" | tr ' ' '+' )"

##one liner
#mpv --force-window=immediate $(yt-dlp -f bestaudio --get-url https://youtu.be/$(curl -s "https://vid.puffyan.us/search?$query" | grep -Eo "/watch\?v=.{11}" | head -n 1))

#making url
vid_id="$(curl -s "$VID/search?q=$query" | grep -Eo "watch\?v=.{11}" | head -n 1)"
vid_url="https://youtu.be/$vid_id"

# capturing only audio url
aud_url="$(yt-dlp -f bestaudio --get-url "$vid_url")"

# playing
#mpv --force-window=immediate "$aud_url"

# title notify
title=$(yt-dlp --get-title "$vid_url")
notify-send "Now Playing: " "$title"

# playing
mpv --force-window=immediate "$aud_url"
