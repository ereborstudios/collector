# collector

On each tick when the `Collect` system runs, any `Collectible` entities intersecting with a `Collector` will be `Collected`.

A typical collector would be a player entity that picks up various items (loot, power-ups...) as it encounters them.

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
collector = "..."
```

Then run `smaug install`.


## Example

```ruby
# app/entities/coin.rb
class Coin < Draco::Entity
  # ...
  component Collectible
end

# app/entities/player.rb
class Player < Draco::Entity
  # ...
  component Collector
end

# app/worlds/collector_example.rb
class CollectorExample < Draco::World
  include Draco::Common::World

  entity Player, as: :player
  entity Coin, as: :coin

  systems Collect, # ...
end
```
