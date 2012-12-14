class Income
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, type: Float
  field :description, type: String
  field :generated_date, type: Date, default: Date.today
  field :repeat, type: Boolean, default: false

  belongs_to :user
  belongs_to :tag

  validates_presence_of :amount, :description, :generated_date, :tag
  validates :amount, :numericality => {:message => "is not valid"}

  default_scope order_by([:generated_date, :desc])
end
