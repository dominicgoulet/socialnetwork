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

  test 'valid user identity' do
    assert @user_identity.valid?
  end
end
