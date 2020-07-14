# radio

## A command line radio player with mpv<br>

### Usage: radio [a radio] or radio option [arg ...]<br>

<pre>
radio fuji<br />
       play a fujiyama radio.<br />

radio<br>
      - play a random radio, press 'q' to play the next.<br>
        this loops infinitely, press ctrl-c to exit.<br>

radio {-r|--rotate}<br>
      - rotate a radio in a specific time.<br>
        this loops infinitely, press ctrl-c to exit.<br>

radio {-a|--all}<br>
      - display all radios, choose a radio number.<br>

radio {-t|--test}<br>
      - test all radios whether work or not.<br>
        If failed, it logs the file named report.<br>

radio {-g|--group} {jp|kr|us|uk}<br>
      - play a random National group,<br>
        press 'q' to play the next.<br>
        this loops infinitely, press ctrl-c to exit.<br>

radio {-h|--help}<br>
      - print this help.<br>
</pre>
