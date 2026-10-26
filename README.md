FOGSIRED is the beginnings of a first person combat game, featuring throwing knives, foggy maps, and push-pull powers inspired by the MISTBORN trilogy. While the enemies aren't fully fledged and hostile, this tutorial part of the game should be enough to let you try out the mechanics I spent the week implementing, and does have most of the movement mechanics functional.

HOW TO PLAY:
You can find a release at: https://github.com/FronchestFry/Godotproject/releases/tag/FOGSIRED, which has an executable for both linux and windows
Mouse to look around, WASD to move, and everything else is explained in the game tutorial

Physics notes: 
  The anchor is pulled to your center of mass, not the hand-orb, despite what the glowing line may want you to think
  The 960 force medium option perfectly cancels gravity, so you will keep going up or down. Flickering one strength higher or lower than that will let you perform small changes and enable perfect hovering

Possible Questions:
  Why can't I push/pull the daggers? They look metal?
    Good question, it's the same reason you only get one coin: I couldn't figure out how to make multiple anchors work. I can keep trying, but for now, you get one push-pull coin, and non-magnetic daggers
  Why is their only one coin?
    See above. Skill issue on my part basically.
  Why is their half-existing code for the ability to dash?
    It was originally gonna be a parkour game, then I switched to alomancy. There's also a wall jump you never really get to use yet, though it is still functional.
  Where are the other metals?
    It's been one week man, give me some time. Realistically, I'm not likely to add all of them anyway, but still.
