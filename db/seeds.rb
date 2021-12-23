
# メインのサンプルユーザーを1人作成する
User.create(
  id: 1,
  name:  "Yuya Hoshi",
  email: "yuya.tennis216@icloud.com",
  password:              "@lasvegas216",
  password_confirmation: "@lasvegas216",
  activated: true,
  activated_at: Time.zone.now,
  admin: true)

Question.create(
 id: 1,
 content: "test question",
 mode_num: 1)
Question.create(
 id: 2,
 content: "test question2",
 mode_num: 1)
Question.create(
 id: 3,
 content: "test statement",
 mode_num: 2)
Question.create(
 id: 4,
 content: "test statement2",
 mode_num: 2)
Question.create(
 id: 5,
 content: "テスト１",
 mode_num: 3)
Question.create(
 id: 6,
 content: "テスト2",
 mode_num: 3)



Answer.create(
  content: "test",
  user_id: 1,
  question_id: 1,
  created_at: Time.current.yesterday)

Item.create(
  content: "test",
  meaning: "testtesttest",
  memo: "This is a test sentence.",
  user_id: 1
)

Notice.create(
  title: "test title",
  content: "test content"
)



