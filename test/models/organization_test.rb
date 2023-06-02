# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id                 :uuid             not null, primary key
#  name               :string
#  website            :string
#  setup_completed_at :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @organization = T.let(organizations(:valid), Organization)
  end

  test 'valid organization' do
    assert @organization.valid?
  end

  test 'invalid without a name' do
    @organization.name = ''

    refute @organization.valid?
    assert_not_nil @organization.errors[:name]
  end

  test '.setup_completed! sets a setup_completed_at and returns true' do
    assert @organization.setup_completed_at.blank?
    assert @organization.setup_completed!
    assert @organization.setup_completed_at.present?
  end

  test '.define_owner! adds user as the owner and returns true' do
    assert_difference('@organization.owners.size', 1) do
      assert @organization.define_owner!(users(:darth_vader))
    end
  end

  test '.add_member! and .remove_member! adds and removes user as a member' do
    user = users(:darth_vader)
    @organization.memberships.delete_all

    assert_difference('@organization.members.size', 1) do
      assert @organization.add_member!(user)
    end

    assert_difference('@organization.members.size', -1) do
      assert @organization.remove_member!(user)
    end
  end

  test '.member? returns true if the user is a member, false otherwise' do
    user = users(:darth_vader)
    @organization.memberships.delete_all

    refute @organization.member?(user)
    @organization.add_member!(user)
    assert @organization.member?(user)
  end

  test '.promote! and .demote! changes the level of the membership between member and admin' do
    user = users(:darth_vader)
    @organization.add_member!(user)
    membership = @organization.memberships.find_by(user:)

    assert T.must(membership).level == 'member'
    @organization.promote!(user)
    T.must(membership).reload
    assert T.must(membership).level == 'admin'

    @organization.demote!(user)
    T.must(membership).reload
    assert T.must(membership).level == 'member'
  end
end
