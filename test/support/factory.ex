defmodule JanjiApi.Factory do
  use ExMachina.Ecto, repo: JanjiApi.Repo

  def promise_maker_factory do
    %JanjiApi.PromiseMakers.PromiseMaker{
      full_name: "Full Name #{Base.encode16(:crypto.strong_rand_bytes(8))}",
      gender: Enum.random(["MALE", "FEMALE"]),
      birthplace: "Birthplace",
      birthdate: ~D[1970-12-31],
      bio: "Bio",
      inserted_by: build(:user),
    }
  end

  def user_factory do
    %JanjiApi.Accounts.User{
      username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
      email: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}@email.com",
      password: nil,
      name: "Some User",
    }
  end

  def set_password(user, password \\ "supersecret") do
    hashed_password = Comeonin.Bcrypt.hashpwsalt(password)
    %{user | password_hash: hashed_password}
  end
end
