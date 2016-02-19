require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test "gli attributi della sezione non devono essere vuoti" do
    section = Section.new
    assert section.invalid?
    assert section.errors[:titolo].any?
    assert section.errors[:descrizione].any?
  end
end
