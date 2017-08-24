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

  def promise_maker_position_factory do
    %JanjiApi.PromiseMakers.Position{
      title: "Title #{Base.encode16(:crypto.strong_rand_bytes(8))}",
      description: "Description",
      inserted_by: build(:user),
    }
  end

  def promise_maker_term_factory do
    %JanjiApi.PromiseMakers.Term{
      promise_maker_position: build(:promise_maker_position),
      promise_maker: build(:promise_maker),
      from_time: ~N[2017-01-01 00:00:00],
      thru_time: ~N[2017-12-31 00:00:00],
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
