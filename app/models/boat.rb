class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all.limit(5)
  end

  def self.dinghy
    Boat.all.where('length < ?', 20)
  end

  def self.ship
    Boat.all.where('length >= ?', 20)
  end

  def self.last_three_alphabetically
    Boat.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.all.where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where('classifications.name' => 'Sailboat')
  end

  def self.with_three_classifications
    joins(:classifications).group('boat_id').having("count(classifications.id) = ?", 3)
  end


end
