# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    before_validation :ensure_session_token

    validates :email, :session_token, uniqueness: true
    validates :email, :session_token, :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        session[:session_token] = nil
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def password=(password)
        self.password = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

end
