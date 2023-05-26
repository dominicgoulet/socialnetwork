# typed: strict
# frozen_string_literal: true

class MembershipsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!

  sig { void }
  def create
    membership = Membership.new(
      user: User.find_by(id: membership_params.user_id),
      organization: Organization.find_by(id: membership_params.organization_id)
    )

    if membership.save
      flash.now.notice = 'An email was sent to the user.'
    else
      flash.now.alert = 'This user is already member of the organization.'
    end

    render_flash!
  end

  sig { void }
  def update
    if T.must(current_membership).update(membership_params.as_json)
      flash.now.notice = 'Congrats.'
    else
      flash.now.alert = 'An error occured.'
    end

    render_flash!
  end

  sig { void }
  def destroy
    if T.must(current_membership).destroy
      flash.now.notice = 'Member removed successfully.'
    else
      flash.now.alert = 'This user could not be removed from the organization.'
    end

    render_flash!
  end

  private

  sig { returns(T.nilable(Membership)) }
  def current_membership
    @current_membership ||= T.let(Membership.find(params[:id]), T.nilable(Membership))
  end

  #
  # MembershipParams
  #

  class MembershipParams < T::Struct
    const :user_id, T.nilable(String)
    const :organization_id, T.nilable(String)
  end

  sig { returns(MembershipParams) }
  def membership_params
    TypedParams[MembershipParams].new.extract!(params.fetch(:membership))
  end
end
