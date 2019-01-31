#!/usr/bin/env python
import retro
#import retro.data
import os
import sys

def imp():
    potential_roms = []
    path = '/Users/metsmania/Works/gym-retro-first/roms/'
    #for path in sys.argv[1:]:
    #    for base, _, files in os.walk(sys.argv[1]):
    #        potential_roms.extend(os.path.join(base, file) for file in files)
    for base, _, files in os.walk(path):
        potential_roms.extend(os.path.join(base, file) for file in files)

    print(potential_roms)
    print('Importing %i potential games...' % len(potential_roms))
    retro.data.merge(*potential_roms, quiet=False)
    print(potential_roms)

imp()

env = retro.make(game='Airstriker-Genesis.md', state='Level1')
env.reset()
for i in range(777):
    env.render()
    env.step(env.action_space.sample())
