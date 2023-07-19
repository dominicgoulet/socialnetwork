# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :uuid             not null, primary key
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @note = T.let(notes(:one), Note)
  end

  test 'valid note' do
    assert @note.valid?
  end
end
