# typed: strict
# frozen_string_literal: true

class UserParams < T::Struct
  const :email, T.nilable(String)
  const :name, T.nilable(String)
  const :password, T.nilable(String)
  const :current_password, T.nilable(String)
end
