# typed: strict
# frozen_string_literal: true

class UserParams < T::Struct
  const :email, T.nilable(String)
  const :first_name, T.nilable(String)
  const :last_name, T.nilable(String)
  const :password, T.nilable(String)
  const :current_password, T.nilable(String)
end
