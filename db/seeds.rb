
# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  activated: true,
  activated_at: Time.zone.now,
  admin: true)

Question.create!(content: "test question",
 mode_num: 1)
Question.create!(content: "test question2",
 mode_num: 1)
Question.create!(content: "test statement",
 mode_num: 2)
Question.create!(content: "test statement2",
 mode_num: 2)



Answer.create!(content: "test",
  user_id: 1,
  question_id: 1,
  created_at: Time.current.yesterday)



