"Exploring Inform 7" by Jeff Nyman

The Test Lab is a room.

The Test Lobby is a room.
It is south of the Test Lab.

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

A container called a mesh basket is in the Test Lab.
The mesh basket is transparent, closed, and openable.
The electronic key is in the mesh basket.

Plato is a person in the Test Lab.

Floyd is a person in the Test Lab.

[ Floyd carrying the key was the initial implementation, which was simple. The next iteration requires him getting the key, which is an obstacle to him opening the glass case which is locked. ]
[ The electronic key is carried by Floyd. ]

[ Without this rule, you would be told "Floyd has better things to do." With the rule in place, you will be told: "Floyd is unable to do that." So you go from him not listening at all to listening but not sure what to do. Note that this rule is not specific to Floyd, but rather is a persuasion rule for any non-player character. ]
A persuasion rule for asking someone to try doing something:
	persuasion succeeds.

[ In this scenario, the "actor attempting to take from a closed item rule" will apply when Floyd attempts to open the glass case. That action will fail due to the "can't open what's locked rule" but that will not actually be reported. ]
Before someone taking something which is in a closed container (called the closed item) (this is the actor attempting to take from a closed item rule):
	try the person asked opening the closed item;
	if the closed item is closed, stop the action.

[ In this scenario, which is the additive with the one above, the "actor attempting to take from a closed item rule" will still apply. But now the "actor attempting to open something locked rule" will also apply. If Floyd has the key, this will succeed and Floyd will end up holding the protomolecule. ]
Before someone opening a locked container (called the closed item) (this is the actor attempting to open something locked rule):
	[ This logic has to be refined from the original example. Since Floyd is not automatically carrying the key as he was originally, the condition has to be broadened out a bit. ]
	[ if the person asked is carrying the matching key of the closed item:
		try the person asked unlocking the closed item with the matching key; ]
	if the person asked can see the matching key of the closed item:
		try the person asked unlocking the closed item with the matching key;
	if the closed item is locked, stop the action.

[ This scenario has to be added in order to make sure that Floyd will actually try to take the matching key. The above rule was changed from Floyd using the key he had to checking if Floyd could see the key. But there still has to be something that tells him to take the key if he can see it. ]
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

Test me with "open case / take protomolecule / floyd, take the protomolecule".