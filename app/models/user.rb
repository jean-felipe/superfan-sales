# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthdate              :datetime
#  code                   :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  document               :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  gender                 :integer          default("masculino")
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          default(0)
#  unconfirmed_email      :string
#  user_type              :integer          default("customer")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  USER_TYPES = %w(customer business)
  GENDER_TYPES = %w(masculino feminino outro)
  STATES = %w(incomplete complete)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :company
  has_many :clients
  has_many :companies, through: :clients

  enum user_type: USER_TYPES
  enum gender: GENDER_TYPES

  validates :document, :code, :email, uniqueness: true

end
