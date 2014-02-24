require 'test_helper'

class LevelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "find_level_by_experience" do
  	levelOne = level(:one)
  	assert_equal levelOne, Level.find_level_by_experience(levelOne.min_experience), "No devuelve el nivel que es"
  end
end
