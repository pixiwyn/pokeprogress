class JwtService
  SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload)
    payload[:exp] = 15.minutes.from_now.to_i
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    JWT.decode(token, SECRET).first
  rescue JWT::DecodeError
    nil
  end
end
