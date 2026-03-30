class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :password, length: { minimum: 8 }, if: :password_required?

    has_many :user_games
    has_many :games, through: :user_games

    has_many :user_pokemon
    has_many :pokemon, through: :user_pokemon

    private

    def password_required?
        new_record? || password.present?
    end
end
