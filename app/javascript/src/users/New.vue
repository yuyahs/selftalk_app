<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">アカウント新規登録</h1>

      <div class="my-4">
        <label for ="user_name"> ユーザーネーム</label>
        <input type="text" v-model="user.name" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <label for ="user_e-mail"> メールアドレス</label>
        <input type="text" v-model="user.email" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <label for="user_password"> パスワード(6文字以上) </label>
        <input type="password" v-model="user.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <label for="user_password_confirmation"> パスワード再入力 </label>
        <input type="password" v-model="user.password_confirmation" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>

      <button @click="createUser" class="mt-4 bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded" >ユーザー登録
      </button>
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
      createUser: function () {
        axios.post('/api/users', {
          user: this.user
        })
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ユーザー登録が完了しました。',
            text:'アカウント有効化メールを送信しました。',
            time: 5000
          });
        })
        .catch(err => {
            this.$router.push({ path: '/users/new'}),
            this.$flashMessage.show({
              type: 'error',
              title: 'ユーザー登録に失敗しました',
              text: '入力内容に誤りがある可能性があります。',
              time: 5000
            });
        })




      }
    }

  }

</script>
