# typed: strict
# frozen_string_literal: true

class PeopleController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!, only: %i[destroy]
  before_action :set_person, only: %i[edit update destroy]

  sig { void }
  def new
    @person = T.let(Person.new, T.nilable(Person))
  end

  sig { void }
  def create
    @person = T.must(current_user).people.build(display_name: person_params.display_name, slug: person_params.slug)

    if @person.save
      return redirect_to complete_setup_path unless T.must(current_user).setup_completed?

      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def edit; end

  sig { void }
  def update
    if T.must(@person).update(display_name: person_params.display_name, slug: person_params.slug)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def destroy
    return unless T.must(@person).destroy

    redirect_to root_path
  end

  private

  sig { void }
  def set_person
    @person = T.let(Person.find(params[:id]), T.nilable(Person))
  end

  #
  # PersonParams
  #

  class PersonParams < T::Struct
    const :display_name, T.nilable(String)
    const :slug, T.nilable(String)
  end

  sig { returns(PersonParams) }
  def person_params
    TypedParams[PersonParams].new.extract!(params[:person])
  end
end
