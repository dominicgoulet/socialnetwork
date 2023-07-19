# frozen_string_literal: true

# == Schema Information
#
# Table name: user_actors
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserActorTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @user_actor = T.let(user_actors(:david_prowse_darth_vader), UserActor)
  end

  test 'factories' do
    assert @user_actor.valid?
  end

  context 'associations' do
    should belong_to(:user)
    should belong_to(:actor)
  end
end
