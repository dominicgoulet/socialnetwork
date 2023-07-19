# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: user_identities
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserIdentity < ApplicationRecord
  extend T::Sig

  ALLOWED_PROVIDERS = T.let(%w[google_oauth2].freeze, T::Array[String])

  # Associations
  belongs_to :user

  # Validations
  validates :provider, presence: true, inclusion: { in: ALLOWED_PROVIDERS }
  validates :uid, presence: true
end
