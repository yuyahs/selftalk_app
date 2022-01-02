<template>
  <div class="form-overall">
    <h1 class="form-title">
      アカウント新規登録
    </h1>

      <!-- 新規登録フォーム -->
      <div class="form-p">
        <label for ="user_name"> ユーザーネーム</label>
        <input type="text" v-model="user.name" class="form-column">
      </div>
      <div class="form-p">
        <label for ="user_e-mail"> メールアドレス</label>
        <input type="text" v-model="user.email" class="form-column">
      </div>
      <div class="form-p">
        <label for="user_password"> パスワード(6文字以上) </label>
        <input type="password" v-model="user.password" class="form-column">
      </div>
      <div class="form-p">
        <label for="user_password_confirmation"> パスワード再入力 </label>
        <input type="password" v-model="user.password_confirmation" class="form-column">
      </div>

      <!-- 新規登録ボタン -->
      <div class="btn-div">
        <button @click="createUser" class="form-btn">
         ユーザー登録
        </button>
      </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {

    name: 'Signup',
    data() {
      return {
        user: {
          name: '',
          email: '',
          password: '',
          password_confirmation: '',
        }
      }
    },
    methods: {
      //新規登録メソッド
      createUser: function () {
        axios.post('/api/users', {
          user: this.user
        })
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
           type: 'success',
           title: 'ユーザー登録が完了しました',
           text:'アカウント有効化メールを送信しました',
           time: 3000
          });
        })
        .catch(err => {
          this.$router.push({ path: '/users/new'}),
          this.$flashMessage.show({
           type: 'error',
           title: 'ユーザー登録に失敗しました',
           text: '入力内容に誤りがある可能性があります',
           time: 3000
          });
        })
      }
    }
  }
</script>
