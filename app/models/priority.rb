class Priority < ActiveRecord::Base
  has_many :tasks

  def to_s
    "#{value} #{description}"
  end
end
