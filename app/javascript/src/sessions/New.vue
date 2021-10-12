<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">ログイン</h1>

      <div class="my-4">
        <label for ="session_e-mail"> メールアドレス</label>
        <input type="text" v-model="session.email" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
      </div>
      <div class="my-4">
        <label for="session_password"> パスワード </label>
        <router-link to='/password_resets/new' class="underline text-blue-900 hover:text-blue-100">(パスワードを忘れた場合)</router-link>
        <input type="password" v-model="session.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
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
  axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  };


  export default {

    name: 'Login',
    data() {
      return {
        session: {
          email: '',
          password: '',
        }
      }
    },
    methods: {
      createSession: function () {
        axios.post('/api/login', {
          session: this.session
        })
        .then(response => {
          this.$store.commit('login', 'token'),
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ログイン',
            text:'ログインに成功しました。',
            time: 5000
          });
        })
        .catch((error) => {
          if(error.message === "Request failed with status code 400") {
             this.$flashMessage.show({
              type: 'error',
              title: 'ログインに失敗しました。',
              text: '入力内容に誤りがある可能性があります。',
              time: 5000
            })
           } if(error.message === "Request failed with status code 401") {
             this.$flashMessage.show({
              type: 'error',
              title: 'ログインに失敗しました。',
              text: 'アカウントが有効化されていません。',
              time: 5000
           })
          }
        })
      }
    }

  }

</script>
