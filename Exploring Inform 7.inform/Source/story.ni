"Exploring Inform 7" by Jeff Nyman

The Test Lab is a room.

The Test Lobby is a room.
It is south of the Test Lab.

[ Adding this to provide nuance to objects, which can determine behavior. ]
A thing can be dangerous or safe.

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
The protomolecule is dangerous.

A container called a mesh basket is in the Test Lab.
The mesh basket is transparent, closed, and openable.
The electronic key is in the mesh basket.

Plato is a person in the Test Lab.

Floyd is a person in the Test Lab.

[ Floyd will now have a curiosity value that can refine his behavior. ]
Floyd has a number called curiosity.
The curiosity of Floyd is 0.

[ It's possible to define something that applies to a value. In this case, Floyd will be defined as curious based on the the value of his curiosity. ]
Definition: Floyd is curious if the curiosity of Floyd is greater than 2.

[ The above persuasion rule has to be changed a bit to make it more specific to Floyd and conditionalized upon his curiosity level. ]
A persuasion rule for asking Floyd to try doing something:
	if Floyd is curious:
		persuasion fails;
	otherwise:
		persuasion succeeds.

[ There has to be some mechanism that allows Floyd's curiosity value to change. This is one of the simplest possible to use for illustrative purposes.  This is now augmented to allow Floyd to exhibit behavior based on his curiosity value. Note that the "is visible" part is used to make sure that any reports about Floyd's behavior will only occur if the player can actually see Floyd. ]
Every turn:
	increment the curiosity of Floyd;
	if the curiosity of Floyd is 2 and Floyd is visible:
		say "Floyd looks a little restless.";
	if the curiosity of Floyd is 3 and Floyd is visible:
		if Floyd can see a dangerous thing (called the item of fascination):
			say "Floyd eyes [the item of fascination] with obvious intent.";
		otherwise:
			say "Floyd glances at you in a slightly shifty way.";
	if the curiosity of Floyd is greater than 3 and Floyd is visible:
		if Floyd carries a the protomolecule:
			try Floyd triggering the protomolecule.

[ This is required in order to allow Floyd to actually trigger the dangerous protomolecule. Just like the escaping action for Plato further down, this action cannot be triggered by the player as there is no context for understanding the idea of "triggering" as a player action. ]

Triggering is an action applying to one touchable thing.

Carry out someone triggering:
	if the noun is the protomolecule:
		end the story saying "The protomolecule immediately expands and consumes everything and everyone in the room."

[ In this scenario, the "actor attempting to take from a closed item rule" will apply when Floyd attempts to open the glass case. That action will fail due to the "can't open what's locked rule" but that will not actually be reported. ]
Before someone taking something which is in a closed container (called the closed item) (this is the actor attempting to take from a closed item rule):
	try the person asked opening the closed item;
	if the closed item is closed, stop the action.

[ In this scenario, which is the additive with the one above, the "actor attempting to take from a closed item rule" will still apply. But now the "actor attempting to open something locked rule" will also apply. If Floyd is able to see the key and if Floyd is able to take the key, this will succeed and Floyd will end up holding the protomolecule. Note, however, that the ability to take the key if it is seen is covered by an additive rule below this one. ]
Before someone opening a locked container (called the closed item) (this is the actor attempting to open something locked rule):
	if the person asked can see the matching key of the closed item:
		try the person asked unlocking the closed item with the matching key;
	if the closed item is locked, stop the action.

[ This scenario exists to make sure that Floyd will actually try to take the matching key. The above rule was changed from Floyd using the key he had to checking if Floyd could see the key. But there still has to be something that tells him to take the key if he can see it. ]
Before someone unlocking a locked container with something which is not carried by the person asked (this is the actor attempts to acquire matching key for locked item rule):
	try the person asked taking the second noun;
	if the person asked does not have the second noun, stop the action.

[ Here we have a specific rule for a particular non-player character but it's one that's largely purely reactive. There is a goal here but it's essentially tied to the goal of the other non-player character being reached. ]
Every turn when Plato can touch the protomolecule:
	try Plato escaping.

Escaping is an action applying to nothing.

[ The notion of "the person asked" here might seem odd. What's happening here is that "try Plato escaping", from the rule above, means that Plato is, in that context, "the person asked"; in this case, "the person asked to try escaping." ]
Carry out someone escaping:
	let space be the location of the person asked;
	let place be a random room which is adjacent to the space;
	let the escape route be the best route from the space to the place;
	try the person asked going the escape route.

Report Plato going a direction (called the escape route):
	say "Plato looks terrified at the protomolecule and heads [escape route]." instead.

Test scenario1 with "wait / wait / wait / floyd, take the protomolecule".
Test scenario2 with "wait / wait / floyd, take the protomolecule".
Test scenario3 with "south / purloin protomolecule then drop it / north".
