
# thatdumbguy

A voice control based song player written in bash




## How it works?

- [ffmpeg](https://ffmpeg.org/) is used to capture a 5 sec audio and save it as a wav audio file.
- [vosk-offline-transcriber](https://alphacephei.com/vosk/) then converts this audio file into possible text combinations.
- web scraping is implemented by using above text as query on one of the many clone sites of youtube to get the video id.
- this id is used to generate the video-url which is used to get the aud-url using [yt-dlp](https://github.com/yt-dlp/yt-dlp).
- [google_speech](https://cloud.google.com/text-to-speech/docs/libraries) is finally used for the output sound and [mpv player](https://github.com/mpv-player/mpv) plays the audio-url.
## Demo

Insert gif or link to demo
