# collector

On each tick when the `Collect` system runs, any `Collectible` entities intersecting with a `Collector` will be `Collected`.

A typical collector would be a player entity that picks up various items (loot, power-ups...) as it encounters them.

All entities with the `Collector` or `Collectible` components should also have `Position`, `Visible`, and `Size` components compatible with [draco-common](https://smaug.dev/packages/draco-common/), so that collisions between them can be calculated.

It is recommended to use [draco-state](https://smaug.dev/packages/draco-state/) to transition between `Collectible` and `Collected` states.

Add your own [observers](https://smaug.dev/packages/draco-events/) to run systems implementing your game logic any time an entity is `Collected`.

The `collector_id` attribute of the `Collected` component captures the `entity.id` of the `Collector`.

![collector-example](https://raw.githubusercontent.com/ereborstudios/collector/master/demo.gif)

## Features

### Components

* Collected
* Collectible
* Collector

### Systems

* Collect

## Installation

In the `Smaug.toml` file of your project, add...

```toml
[dependencies]
draco = "0.6.1"
draco-common = "0.1.1"
draco-periodic = "0.2.0"
draco-state = "0.2.0"
draco-events = "0.2.0"
collector = "0.1.0"
```

Then run `smaug install`.


## Example

```ruby
# app/entities/coin.rb
class Coin < Draco::Entity
  include Draco::State
  state [Collectible, Collected]
  # ...
end

# app/entities/player.rb
class Player < Draco::Entity
  # ...
  component Collector
end

# app/systems/collecting.rb
class Collecting < Draco::System
  filter Collected

  def tick(args)
    entities.each do |entity|
      $gtk.notify! "Collected #{world.filter(Collected).count} entities."
    end
  end
end

# app/worlds/collector_example.rb
class CollectorExample < Draco::World
  include Draco::Events
  include Draco::Common::World

  entity Player, as: :player
  entity Coin, as: :coin

  systems Collect, # ...

  observe Collecting
end
```
