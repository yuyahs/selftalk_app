<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">ログイン</h1>

      <div class="my-4">
        <label for ="session_e-mail"> メールアドレス</label>
        <input type="text" v-model="session.email" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <label for="session_password"> パスワード </label>
        <input type="password" v-model="session.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <input type="hidden" value="0" v-model="session.remember_me">
        <input type="checkbox" value="1" v-model="session.remember_me">
        <span>ログイン状態を保持する</span>
      </div>

      <div class="flex flex-row">
        <button @click="createSession" class="w-1/2 mt-4 bg-blue-500  text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-white rounded-full" >
        ログイン
        </button>
        <router-link to="/users/new" class="ml-4 mt-6 underline text-right text-blue-900 hover:text-blue-100">
        新規登録はこちらから!</router-link>
      </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {

    name: 'Login',
    data() {
      return {
        session: {
          email: '',
          password: '',
          remember_me: '',
        }
      }
    },
    methods: {
      createSession: function () {
        axios.post('/api/login', {
          session: this.session
        })
        .then(response => {
          this.$router.push({ path: '/courses'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ログイン',
            text:'ログインに成功しました。',
            time: 5000
          });
        })
        .catch(err => {
            this.$router.push({ path: '/login'}),
            this.$flashMessage.show({
              type: 'error',
              title: 'ログインに失敗しました。',
              text: '入力内容に誤りがある可能性があります。',
              time: 5000
            });
        })

      }
    }

  }

</script>
