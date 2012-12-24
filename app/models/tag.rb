class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :incomes_counter, type: Integer, default: 0
  field :expenses_counter, type: Integer, default: 0

  belongs_to :user
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, :uniqueness => { :case_sensitive => false }

  default_scope order_by([:name, :asc])
  scope :include_component, ->(component) { includes(component.to_sym)}

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

  ['incomes', 'expenses'].each do |components|
    define_method('sorted_' + components) do 
      hash = {}
      self.send(components).each do |component|
        key = component.generated_date
        hash[key] ||= []
        hash[key] << component
      end
      hash
    end
  end


end
