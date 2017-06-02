/*
[Fade in a rotating Kerbin north polar view]

[Title text] Braking maneuver

Imagine you have your orbit set up so that you (the chaser) are on a collision course with
the target. This means that the chaser [fade in the yellow orbit] and target orbits [fade 
in the green orbit] intersect, and both the chaser [fade in chaser dart] and the target
[fade in target dart] are going to reach the intersection at the same time. [Once the target
dart fades in, allow about 5 seconds, then show the chaser and target dots colliding and
exploding].

[Once explosion fades out, leave both orbits but no darts] Note that you need both of these
things, an orbit intersect and the right timing. If the chaser arrives at the intersection
earlier or later, then it won't collide. [Fade in the chaser, then the target two seconds 
later. Chaser will reach intersection about 5 seconds after target fades in, two seconds 
before target does. There must be some visible clearance between chaser and target at all
times] When the chaser is at the intersection, the target either has some time left to go, 
or has already passed. [Rerun with the chaser arriving after the target] In any case, 
there is a minimum distance between the chaser and target. [Zoom in and move relative to 
target, showing minimum distance]. Note that this is not exactly when the chaser reaches 
the intersection, but it will be close to then.

So, let's imagine that you, the chaser, have run through the entire rendezvous program and
are now on a collision course with your brand new million-fund space station. Or let's say
that you are trying to rescue Jeb and Jeb doesn't react well to squishing. How do you turn
your intercept into a rendezvous? This is the purpose of the braking maneuver. The goal 
state is to be floating next to the target, with no relative motion, close enough that 
you can ignore tides and just fly around by the seat of your pants. In near-Kerbin orbit,
this is within a couple hundred meters.

[Switch to actual Kerbal Space Program footage]
This is the easiest part of the whole maneuver sequence. There is some math involved, but
you should be able to do it in your head. First, set your vectorball to show relative
motion with respect to the target. In this view, the prograde and retrograde vectors
are relative to the target, so if you point at the prograde, you are pointing in your
direction of motion relative to the target, and vice versa. Your speedometer is now
showing the few meters per second speed relative to the target, rather than the multiple
kilometers per second relative to the ground below you.

Let's start with a collision course. You have set up your intercept perfectly, and are
moving at 10m/s directly towards the target. Your vehicle might have an acceleration of
1m/s. You can figure this out by dividing the thrust by the mass of your vehicle. So if
your vehicle masses 5000kg and you have a maneuvering engine with 20000N, you will have
an acceleration of 4m/s^, and it will take 2.5s to slow down and brake. I personally think
this is too short, so I would use the thrust control to turn down the thrust until it takes
about 10s to do the maneuver. Your comfort with doing precise maneuvers may vary. As another
real-world example, the space shuttle orbiter weighed about 100,000kg including fuel and had
two main maneuvering engines with a total of about 50kN of thrust. This vehicle then has
an acceleration of 0.5m/s^2, and it would take 20s to slow down.

Let's say you have an engine that can do 1m/s, and you are approaching at 10m/s. If you take 
10s to slow down, what happens if you start your braking maneuver 10s before collision? 
Multiply this time by your speed to find out that this is 100m away from the target.

First, you will not end up covering the remaining 100m in 10 seconds, since you will be slowing
down the whole time. If you remember any physics classes, you probably remember constant 
accelerated motion. [Show the equation s=1/2at^2+v_0t+s_0 and a graph of this motion] This is 
where you are while you move with constant acceleration (or decelleration). s_0 is your distance
from the target when you start braking. Note that if you didn't do anything, [turn accelration to
zero and indicate collision point and time] a would be 0 and you would collide (s=0) at t=10 
seconds. But you are doing something. [Turn acceleration back on] You will come to a stop some
distance away from the target. This is probably a good thing for not bending you new space
station or turning Jeb into chunky salsa.

Second, the whole time you are braking, you will be hosing down the target with rocket exhaust.
This effect isn't modeled in KSP, so it's up to you the pilot how realistic you want to be with 
this.

Braking then is simple. Point so your thrust is towards retrograde (point away from the target
in a conventional vehicle with the main engine in its tail) and throttle up at some point before
you will hit. The closer you get to the target before you start braking, the closer you will be
when you finish, if you don't hit. So, it just depends on how brave you are.

If you want, you can set a maneuver node right at the intersection, and fiddle with the maneuver
until the post-maneuver chaser orbit matches the target orbit. In this case, the maneuver display
on the vectorball will give you perfect time and delta-v information. You can rely on that.

What if you didn't perfectly aim for the target? Suppose your closest approach is 100m away? This
is no problem either. Do the braking maneuver exactly the same, then fly directly from where you 
stop to the target.

NASA doesn't quite do things this way. They split the braking maneuver up into several smaller
maneuvers, and they never aim for a collision course. They aim for a point in space a fixed
distance away from the target, on the line from the center of the planet to the target. This
line is called the "R-bar". You can't really park there, since you will be closer to the planet
but moving at the same speed as the target, IE the right speed to orbit at a different place.
However, things are moving slowly enough here that the space shuttle would do it's rendezvous
pitch maneuver here so that the crew of the station could inspect the heat shield. Robotic 
cargo ships aim for this point on the R-bar too. In fact, their autopilots are designed to 
not cross within a "keep-out-sphere" until given permission from the station crew and the ground.
They will aim for a point on the R-bar just outside the keep-out sphere. Once there, they will
be commanded to come in, to either automatically dock, or wait at another fixed point much
closer to the station to get picked up by the station arm. Stock KSP doesn't have tools for aiming
for a point offset from the target, so we just won't do things this way.

And now you know how to brake. 

This has been Kwan3217, saying "If at first you don't succeed, fly fly again"


*/