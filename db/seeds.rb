
# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  activated: true,
  activated_at: Time.zone.now,
  admin: true)

Question.create!(content: "test question")

Statement.create!(content: "test statement")

Answer.create!(content: "test",
  user_id: 1,
  question_id: 1,
  created_at: Time.current.yesterday)

Reaction.create!(content: "reaction 1",
  user_id: 1,
  statement_id: 1,
  created_at: Time.current.yesterday)

