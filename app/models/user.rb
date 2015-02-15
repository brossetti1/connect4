class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true

  has_one :user_profile
  has_many :games

  has_many :players
  has_many :games, through: :players

  def prompt_user(prompt, validator, error_msg, clear_screen: nil)
    `clear` if clear_screen
    puts "\n#{prompt}\n"
    result = gets.chomp
    until result =~ validator
      puts "\n#{error_msg}\n"
      result = gets.chomp
    end
    puts
    result
  end

end
