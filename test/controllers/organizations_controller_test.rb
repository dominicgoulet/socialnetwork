# typed: strict
# frozen_string_literal: true

require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    @user = T.let(users(:darth_vader), User)
    @organization = T.let(organizations(:valid), Organization)

    sign_in!(@user)
  end

  #
  # Index
  #

  test 'list all my organizations' do
    get organizations_url

    assert_response :ok
  end

  #
  # New
  #

  test 'shows the new organization form page' do
    get new_organization_url

    assert_response :ok
  end

  #
  # Show
  #

  test 'shows nothing given invalid params' do
    get organization_url(0)

    assert_response :not_found
  end

  test 'shows the organization given valid params' do
    get organization_url(@organization.id)

    assert_response :ok
  end

  #
  # Create
  #

  test 'does not create a new organization given invalid params' do
    post organizations_url, params: {}

    assert_response :unprocessable_entity
  end

  test 'creates a new organization given valid params' do
    post organizations_url, params: { organization: { name: 'The Republic' } }

    assert_redirected_to organization_path(id: T.must(Organization.find_by(name: 'The Republic')).id)
  end

  #
  # Edit
  #

  test 'shows no edit form given invalid params' do
    get edit_organization_url(0)

    assert_response :not_found
  end

  test 'shows the organization edit form given valid params' do
    get edit_organization_url(@organization.id)

    assert_response :ok
  end

  #
  # Update
  #

  test 'does not update the organization given invalid params' do
    patch organization_url(@organization.id)

    assert_response :unprocessable_entity
  end

  test 'updates the organization given valid params' do
    patch organization_url(@organization.id), params: { organization: { name: 'The Updated Empire' } }

    assert_redirected_to organization_path(id: @organization.id)
  end

  #
  # Destroy
  #

  test 'deletes the organization given valid params' do
    delete organization_url(@organization.id), as: :turbo_stream

    assert_response :ok
  end
end
