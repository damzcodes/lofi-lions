class MasterText < ActiveRecord::Base

  has_many :localized_texts, inverse_of: :master_text, dependent: :destroy
  has_many :key_placements, inverse_of: :master_text
  has_many :views, through: :key_placements

  validates :key, presence: true, uniqueness: true
  validates :other, presence: true

  def text= text
    self.other= text
  end
  def text
    raise Exception.new("Don't use text when pluralizable") if self.pluralizable
    self.other
  end
  def text_changed?
    return true if self.other_changed?
    return true if self.one_changed?
    return true if self.pluralizable_changed?
    false
  end
end
