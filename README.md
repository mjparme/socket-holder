# Overview

This project is a modification of the OpenSCAD code at https://www.printables.com/model/442405-parametric-openscad-magnetic-socket-organiser by user @michaelh

The original is licensed Creative Commons (4.0 International License) Attribution-ShareAlike (https://creativecommons.org/licenses/by-sa/4.0/legalcode). By the terms of the license that is also the license of this modification.

# Changes

## General Cleanup

* The casing of the variables was all over the place, I standarized on camel-case and renamed accordingly (snake-case is an abomination)
* Refactored the code so it used reusable modules and removed the redundent text code and put it on a module
* Renamed some variables to have a more descriptive and/or accurate name

## Organization Changes

* The code now has a single starting point `socketHolder.scad` and it includes a `commonConfig.scad` that contains all the supported configuration settings. Any value in this file can be overridden in a more specific config file. If not overriden it retains the value found in `commonConfig.scad`
* Each socket holder has a config file that is included in `socketHolder.scad`, simply uncomment the holder you want or add a new include line
for a new holder config. Only the values that are different from `commonConfig.scad` need to be put in this file.
* All config files have been moved into a `config` sub-directory

## Design Changes

* Instead of using manually entered `socketDepths` it has been changed to `socketHeights` and you simply input the measured height of your socket. The depth of the hole will be `socketHeight / 2`.
* The height of the first step is no longer a statically configured value. Instead it is calculated with `max socket hole depth on first step + magentThickess + holeClearance`
* Subsequent steps are no longer a statically configured delta above previous step. You now set a minumum step delta height and it will be at least that high. However, if there is a deeper socket on the next step the hole may be deeper. This fixes the situation when the first step has really short sockets, but the next step has deep sockets. We never have the situtation where a subsequent step may be too short.
  * *NOTE:* The height of the first and subsequent steps are calculated by the same list comprehension, take a look at the comprehensions for `minimumStepHeights`, `stepHeightDeltas`, and `stepHeights`
* Removed the scaling factor thing the original had going on. I see why it was done like that but I thought it created much more spacing than
was necessary which wasted filament. Instead it has been replaced with static config values `distanceBetweenHoles` and `stepMargin`. The one drawback to this approach vs the scaling approach is you may have to adjust `distanceBetweenHoles` to make sure the labels don't overlap. This is especially necessary for imperial sockets with double digit numerators/denominators next to each other e.g. 11/16 and 13/16. But for metric sockets and single digit fractions this approach lets you get the holes pretty close together which saves filament.
* The labels can now optionally be printed separately. This is actually the change I wanted to do that sent me down the rabbit hole of all the other changes I did. Set `includeLabels` to either true or false. If false you can render the labels separately by setting the `PART` variable to `labels`. This way you can do a color swap for the actual labels.


