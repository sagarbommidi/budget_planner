class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user
  has_many :incomes
  has_many :expenses

  validates :name, presence: true, :uniqueness => { :case_sensitive => false }

  default_scope order_by([:name, :asc])

  def self.find_or_create_tags(names, user)
    tags = []
    names.strip.split(',').each do |value|
      value = value.strip.downcase
      unless value.blank?
        tag = user.tags.where(:name => value).first || user.tags.create!(:name => value)
        tags << tag
      end
      user.save #to save the associated objects to user object incase of creating new tags
    end
    tags
  end

end
