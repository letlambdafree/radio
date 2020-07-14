# radio

A command line radio player with mpv

 Usage: radio [option] or radio [a radio url]

        radio : random a radio, press 'q' to play a next random url.
                this loops infinitely, press ctrl-c to exit.

        radio g {jp|kr|us|uk} : random a National group,
                                press 'q' to play a next random url.
                                this loops infinitely, press ctrl-c to exit.

        radio , : rotate a radio in a specific time.
                  this loops infinitely, press ctrl-c to exit.

        radio . : display all radios, choose a wanted radio number.

        radio TEST : test radios whether work or not.
                     If failed, it logs the file named report.

        radio fuji : play a fujiyama radio.

        radio {h|H|-h|--help} : print this help message.
