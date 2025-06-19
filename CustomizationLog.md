## Script challenges

I wanted to improve the ducking of the music during speech callouts.  Currently,
the table script will call playmedia() with a fixed length of time for ducking.
But under the hood, playmedia() is often calling PuPlayer.playlistplayex() with
a directory of audio files.  playlistplayex() will randomly select one of the clips
for playback.  But the clips are all different lengths (sometimes drastically different)

There's no real way to know what audio file playlistplayex() is playing, so even if
you knew the length of every audio clip, you wouldn't know how long to duck for.

I had hoped to find a reference to the PinUpPlayer.PinDisplay ActiveX control to 
see if there were other audio playback options, maybe one where I could randomly
select one of the clips in the folder and play it back explicitly with a ducking
timeout appropriate for that file.

But I have found no such reference.  If I had the full Visual Studio, I would probably
be able to examine the dll for the PinUpPlayer.PinDisplay.  But that's a lot.

One option would be to find the longest clip in each folder and use that for the
duck timeout.  But if some clips are 5 seconds, and one is 25, do you really want
to duck for 25 seconds?

Ultimately, I ended up dropping the music volume (VolMusic).  Going from 90 to 70
made it a lot easier to understand the speech callouts.


## Table Configuration

### cabinet mod

There is a cabinet mod available on vp spreadsheet.  It is supposed to improve the lighting
and POV.  It requires the VPU Patching System (I found that VPin Studio supports such
patching, so I did it that way).  But the patched version would not launch.  

### DMD positioning woes

The DMD (just the horizontal box where scores are shown) was horizontally and vertically centered. 
That didn't work with the full DMD artwork I selected.  It really needed to be in the lower third of 
the display.

- Tried to set the DMDMode and PuPDMDDriverType, but they had no effect
- tried using VPin Studio to set the position of the DMD
- tried the old technique of mousing over to the third display, moving the DMD, and right-clicking to save it; I was actually able to move it, but there was no right-click menu that came up, no matter what I did.
- Finally found the fix: edit the PinUpPlayer.ini file in the table's PUP Videos folder.  The DMD for our table is specified under [INFO 1]