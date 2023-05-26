# typed: strict
# frozen_string_literal: true

# module Interactors
class InteractorResponse
  extend T::Sig

  class InteractorResponseState < T::Enum
    extend T::Sig

    enums do
      Pristine = new
      Success = new
      Failure = new
    end
  end

  sig { void }
  def initialize
    @messages = T.let([], T::Array[String])
    @state = T.let(InteractorResponseState::Pristine, InteractorResponseState)
  end

  sig { returns(T::Array[String]) }
  attr_accessor :messages

  sig { returns(InteractorResponseState) }
  attr_accessor :state

  sig { void }
  def success!
    @state = InteractorResponseState::Success
  end

  sig { returns(T::Boolean) }
  def success?
    @state == InteractorResponseState::Success
  end

  sig { void }
  def fail!
    @state = InteractorResponseState::Failure
  end

  sig { returns(T::Boolean) }
  def failed?
    @state == InteractorResponseState::Failure
  end

  sig { returns(T::Boolean) }
  def pristine?
    @state == InteractorResponseState::Pristine
  end
end
# end
