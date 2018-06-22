class User < ApplicationRecord

  has_secure_password
  #attr_accessor :password
  # Validations
  validates_presence_of :fullName, :email#, :password_digest
  validates_uniqueness_of  :email
  has_attached_file :profile_picture, { url: "/system/User/:id/profile_picture/#{Digest::SHA256.base64digest("yogesh")[0..20]}/profile_picture.:extension"}
  validates_attachment_content_type :profile_picture, content_type: /\Aimage/
  validates_attachment_file_name :profile_picture, matches: [/png\z/, /jpe?g\z/ , /jpeg\z/]
  do_not_validate_attachment_file_type :profile_picture

  has_many :buyer_requirements#, dependent: :destroy
  has_one :subscription
  has_one :plan, :through => :subscription
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def self.profile_picture_url(profile_picture)
     profile_picture.url.dup.prepend("https://re-tradex.herokuapp.com")
  end

  

  #def generate_confirmation_instructions
  #  self.confirmation_token = generate_token
  #  self.confirmation_sent_at = Time.now.utc
  #end

  def generate_confirmation_instructions
    self.confirmation_token = generate_token
    self.confirmation_sent_at = Time.now.utc
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save!
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 24.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save
  end

  def update_new_email!(email)
    self.unconfirmed_email = email
    self.generate_confirmation_instructions
    save
  end

  def self.email_used?(email, id)
    existing_user = User.where(email: email, id: id )
    if !existing_user.present?
      return true
    else
      return false
    end
  end

#  def update_new_email!
#    self.email = self.unconfirmed_email
#    self.unconfirmed_email = nil
#    self.mark_as_confirmed!
#  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end


