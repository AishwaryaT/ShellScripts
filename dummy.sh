# Creates a dummy process with a name and sleeps till killed.

perl -e '$0="dummy"; sleep infinity' &
