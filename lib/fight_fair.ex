defmodule FightFair do
  def hello do
    :world
  end

  def migrate do
    FightFair.Release.migrate()
  end
end
