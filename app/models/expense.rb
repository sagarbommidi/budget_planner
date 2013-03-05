class Expense
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, type: Float
  field :description, type: String
  field :generated_date, type: Date, default: Date.today
  field :repeat, type: Boolean, default: false
  # field :repeat_mode, type: String # give the default as null

  belongs_to :user
  belongs_to :tag

  validates_presence_of :amount, :description, :generated_date, :tag
  validates :amount, :numericality => {:message => "is not valid"}

  default_scope order_by([:generated_date, :desc])
  
  before_create :tag_counter_increment
  before_destroy :tag_counter_decrement

  private

  def tag_counter_increment
    tag.inc(:incomes_counter, 1)
  end

  def tag_counter_decrement
    tag.inc(:incomes_counter, -1)
  end
end