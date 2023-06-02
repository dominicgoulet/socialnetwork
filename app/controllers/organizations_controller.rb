# typed: strict
# frozen_string_literal: true

class OrganizationsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!
  before_action :set_organization, only: %w[show edit update destroy]

  sig { void }
  def index
    @organizations = T.let(Organization.all, T.nilable(ActiveRecord::Relation))
  end

  sig { void }
  def new
    @organization = Organization.new
  end

  sig { void }
  def show; end

  sig { void }
  def create
    organization = Organization.new(organization_params.as_json)

    if organization.save
      redirect_to organization
    else
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def update
    if T.must(@organization).update(organization_params.as_json)
      redirect_to @organization
    else
      render :edit, status: :unprocessable_entity
    end
  end

  sig { void }
  def destroy
    if T.must(@organization).destroy
      flash.now.notice = 'Organization deleted successfully.'
    else
      flash.now.alert = 'Organization could not be deleted.'
    end

    render_flash!
  end

  private

  sig { void }
  def set_organization
    @organization = T.let(Organization.find(params[:id]), T.nilable(Organization))
  end

  #
  # OrganizationParams
  #

  class OrganizationParams < T::Struct
    const :name, T.nilable(String)
  end

  sig { returns(OrganizationParams) }
  def organization_params
    TypedParams[OrganizationParams].new.extract!(params.fetch(:organization))
  end
end
