# typed: strict
# frozen_string_literal: true

class BrandsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!, only: %i[destroy]

  sig { void }
  def new
    @brand = T.let(Brand.new, T.nilable(Brand))
  end

  sig { void }
  def create
    @brand = T.must(current_user).brands.build(brand_params)

    if @brand.save
      redirect_to root_path
    else
      flash.now.alert = @brand.errors
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def edit
    @brand = T.let(Brand.find(brand_params.id), T.nilable(Brand))
  end

  sig { void }
  def destroy
    sign_out_and_redirect!
  end

  private

  #
  # BrandParams
  #

  class BrandParams < T::Struct
    const :id, String
    const :display_name, String
    const :slug, String
  end

  sig { returns(BrandParams) }
  def brand_params
    TypedParams[BrandParams].new.extract!(params)
  end
end
