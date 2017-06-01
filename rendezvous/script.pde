/*
Prerequisites:
  1) Orbits
    a) On conics - no coasting straight lines
    b) Higher is slower
  2) Maneuvering
    a) prograde
    b) retrograde
    c) normal
    d) radial
    
Rendezvous the NASA way

Show the steps backwards. The final desired position is zero distance, zero relative
speed. If you are on a collision course with the target, you will want to do a ''braking
maneuver'' before you hit it, to cancel out any relative speed. On a collision course,
you are on an orbit which crosses the target orbit, and both you and the target will 
take the same time from now to then to get there. Depending on your speed and thrust,
you will do a braking maneuver to cancel your relative velocity with the target as
you approach it. Once you are within a couple of hundred meters, you can start to fly
straight towards the target. Inside this range, gravity and tides are negligible, and
you can fly in zero-G like everyone thinks you can in space. 

To brake, use the vectorball to point directly opposite the target motion, and fire 
until the velocity reaches zero.

Braking math can be done in your head. Let's say you are moving towards the target at
10m/s, and you have 1m/s^2 acceleration. You will need to decelerate for 10s to reach
zero relative speed. If you recall accelerated motion from high-school physics, an 
object travels s=(1/2)at^2. In our case, t^2 is 100 s^2, since you are braking for 
10s. Acceleration a is 1, so the distance traveled is 50m. If you start braking 50m
away from the target, you will gently kiss its hull at 0m/s 10 seconds later.

Note that from the point of view of the planet, you are thrusting in whatever direction
is necessary to match velocity with the target.

Now, NASA doesn't do this -- they brake such that they come to a halt before contact.
Generally a spacecraft visithing the ISS aims for and stops a couple hundred meters
from the station. It would be a shame for a vehicle to be on a collision course with
the station when its guidance fails, so vehciles are aimed for a point a short distance
away. They come to a halt there, prove that they are still controllable, then pull the
rest of the way in using intuitive zero-G maneuvers.

That's what we do in KSP also. It's hard to aim for a point away from the target, so
aim at the target, but don't worry too much about getting closest approach to zero. 0.1 
is plenty close enough 

* The final step is to brake 
  
*/