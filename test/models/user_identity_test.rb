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
require 'test_helper'

class UserIdentityTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @user_identity = T.let(user_identities(:valid), UserIdentity)
  end

  test 'factories' do
    assert @user_identity.valid?
  end

  context 'associations' do
    should belong_to(:user)
  end

  context 'validations' do
    should validate_presence_of(:uid)
    should validate_presence_of(:provider)
    should validate_inclusion_of(:provider).in_array(UserIdentity::ALLOWED_PROVIDERS)
  end
end
