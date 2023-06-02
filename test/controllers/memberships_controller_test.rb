# typed: strict
# frozen_string_literal: true

require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    @user = T.let(users(:darth_vader), User)
    @organization = T.let(organizations(:valid), Organization)
    @membership = T.let(memberships(:valid), Membership)

    sign_in!(@user)
  end

  #
  # Create
  #

  test 'create should fail given invalid params' do
    post memberships_url

    assert_response :unprocessable_entity
  end

  test 'should create a new membership given valid params' do
    post memberships_url, params: {
      membership: {
        user_id: @user.id,
        organization_id: @organization.id
      }
    }, as: :turbo_stream

    assert_response :ok
  end

  #
  # Update
  #

  test 'update should fail given invalid params' do
    patch membership_url(@membership.id)

    assert_response :unprocessable_entity
  end

  test 'should update membership given valid params' do
    patch membership_url(@membership.id), params: {
      membership: {
        user_id: @user.id,
        organization_id: @organization.id
      }
    }, as: :turbo_stream

    assert_response :ok
  end

  #
  # Destroy
  #

  test 'should delete membership' do
    delete membership_url(@membership.id), as: :turbo_stream

    assert_response :ok
  end
end
