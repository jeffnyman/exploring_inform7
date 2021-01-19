"Exploring Inform 7" by Jeff Nyman

The Test Lab is a room.

A container called the glass case is in the Test Lab.

[ To Inform, containers are, by default, set up as such:

* opaque, not transparent
* open, not closed
* unopenable, not openable
* unlocked, not locked
* not lockable
* not enterable

So the below logic essentially changes the container almost entirely from the default. ]

The glass case is transparent, closed, openable, locked, and lockable.

The matching key of the glass case is an electronic key.

The glass case contains a protomolecule.

Floyd is a person in the Test Lab.
The electronic key is carried by Floyd.

[ Without this rule, you would be told "Floyd has better things to do." With the rule in place, you will be told: "Floyd is unable to do that." So you go from him not listening at all to listening but not sure what to do. Note that this rule is not specific to Floyd, but rather is a persuasion rule for any non-player character. ]
A persuasion rule for asking someone to try doing something:
	persuasion succeeds.

[ In this scenario, the "actor attempting to take from a closed item rule" will apply when Floyd attempts to open the glass case. That action will fail due to the "can't open what's locked rule" but that will not actually be reported. ]
Before someone taking something which is in a closed container (called the closed item) (this is the actor attempting to take from a closed item rule):
	try the person asked opening the closed item;
	if the closed item is closed, stop the action.

Test me with "open case / take protomolecule / floyd, take the protomolecule".