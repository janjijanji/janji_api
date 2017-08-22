defmodule JanjiApi.Factory do
  use ExMachina.Ecto, repo: JanjiApi.Repo

  def user_factory do
    %JanjiApi.Accounts.User{
      username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
      email: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}@email.com",
      password: "supersecret",
      name: "Some User",
    }
  end

  def set_password(user, password \\ "supersecret") do
    hashed_password = Comeonin.Bcrypt.hashpwsalt(password)
    %{user | password_hash: hashed_password}
  end
end
