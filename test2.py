import retro
def main():
    env = retro.make(game='StreetFighterIISpecialChampionEdition-Genesis', state='Champion.Level1.RyuVsGuile')
    obs = env.reset()
    env.render()
    #while True:
        #obs, rew, done, info = env.step(env.action_space.sample())
        #env.render()
        #if done:
        #    obs = env.reset()
if __name__ == '__main__':
    main()
