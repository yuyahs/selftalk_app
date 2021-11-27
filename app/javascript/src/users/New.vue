<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8">
    <h1 class="text-center font-bold text-2xl mb-6">
      アカウント新規登録
    </h1>

      <!-- 新規登録フォーム -->
      <div class="form-p">
        <label for ="user_name"> ユーザーネーム</label>
        <input type="text" v-model="user.name" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="form-p">
        <label for ="user_e-mail"> メールアドレス</label>
        <input type="text" v-model="user.email" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="form-p">
        <label for="user_password"> パスワード(6文字以上) </label>
        <input type="password" v-model="user.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="form-p">
        <label for="user_password_confirmation"> パスワード再入力 </label>
        <input type="password" v-model="user.password_confirmation" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>

      <!-- 新規登録ボタン -->
      <div class="mt-4">
        <button @click="createUser" class="w-1/2 bg-blue-500  text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-white rounded-full" >
         ユーザー登録
        </button>
      </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {

    name: 'New',
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
