# TODO: support building to multiple targets
odin build nakama/ -show-timings -collection:shared=nakama -out:nakama -build-mode:shared -opt:2 -microarch:native -vet -target:windows_amd64
