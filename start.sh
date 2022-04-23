docker run -d --env-file default.env -v steam:/home/steam/Steam -v ark:/ark -p 27015:27015 -p 27015:27015/udp -p 7778:7778 -p 7778:7778/udp -p 7777:7777 -p 7777:7777/udp thmhoag/arkserver
