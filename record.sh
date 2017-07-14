arecord -D plughw:1,0 -d 10 -f S16_LE -c1 -r44100 -t wav `date +%s`.wav
