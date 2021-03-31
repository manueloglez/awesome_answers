class User < ApplicationRecord
  has_secure_password
  validates(
    :email, 
    uniqueness: true,
    presence: true,
    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  )
  
  def full_name
    "#{first_name} #{last_name}".strip
  end

end
