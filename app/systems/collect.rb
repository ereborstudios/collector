class Collect < Draco::System
  filter Position, Size, Visible, Collectible

  def tick(args)
    collectors = world.filter(Collector)

    entities.each do |entity|
      collector = collectors.find { |collector| collides?(entity, collector) }

      if collector
        entity.components.delete(entity.components[:collectible])
        entity.components.delete(entity.components[:visible])
        entity.components.add Collected.new
        $gtk.notify! "Collected #{world.filter(Collected).count} entities."
      end
    end
  end

  def collides?(entity, collector)
    make_rect(entity).intersect_rect?(make_rect(collector))
  end

  def make_rect(entity)
    {
      x: entity.position.x,
      y: entity.position.y,
      w: entity.size.width,
      h: entity.size.height
    }
  end
end
