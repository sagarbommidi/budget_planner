class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  field :roles_mask, type: Integer
  field :full_name, type: String

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  # validates_presence_of :email
  # validates_presence_of :encrypted_password

  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :tags, dependent: :destroy

  # see https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
  ROLES = %w[admin user]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end

  def tag_names
    tags.collect(&:name)
  end

  def sorted_tags(components)
    hash = {}
    tags.includes(components.to_sym).each do |tag|
      if tag.send("#{components}_counter") > 0
        key =  tag.name[0].downcase
        hash[key] ||= []
        hash[key] << tag
      end
    end
    hash.sort
  end
  
  ['incomes', 'expenses'].each do |components|
    define_method('sorted_' + components) do 
      hash = {}
      self.send(components).each do |component|
        key =  component.generated_date
        hash[key] ||= []
        hash[key] << component
      end
      hash
    end
  end
end
