# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @comment = T.let(comments(:one), Comment)
  end

  test 'valid comment' do
    assert @comment.valid?
  end
end
