# typed: strict
# frozen_string_literal: true

require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  extend T::Sig

  #
  # We use OrganizationsController just as a mean to test the
  # various common features in ApplicationController.
  #

  # setup do
  #   @user = T.let(users(:darth_vader), T.nilable(User))
  #   @organization = T.let(organizations(:valid), T.nilable(Organization))
  # end

  # test 'should handle invalid records' do
  #   sign_in!(T.must(@user))

  #   get organization_url(id: 'invalid-id')

  #   assert_response :not_found
  # end

  # test 'should handle invalid parameters' do
  #   patch passwords_url, params: {}

  #   assert_response :unprocessable_entity
  # end

  # test 'should handle missing parameters' do
  #   sign_in!(T.must(@user))

  #   post organizations_url,
  #        params: {
  #          organization: {}
  #        }

  #   assert_response :unprocessable_entity
  # end
end
