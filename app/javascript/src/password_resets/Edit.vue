<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">新しいパスワードを設定する</h1>
    <input type="hidden" :value="email">

    <label for="user_password">新しいパスワード</label>
    <input type="password" v-model="user.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">

    <label for="user_password_confirmation">パスワード再入力</label>
    <input type="password" v-model="user.password_confirmation" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">

    <button @click="setPassword" class="mt-4 w-2/5 bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">
      再設定
    </button>

 </div>

</template>

<script>
  import axios from 'axios';

  const token = Math.random().toString(32).substring(2)

  export default {

    name: 'Change',
    data() {
      return {
        user: {
          password: "",
          password_confirmation: "",
        },
          email: this.$route.query.email
      }
    },
    methods: {
      setPassword: function () {
        axios.patch(`/api/password_resets/${this.$route.params.reset_token}`, {
        user: this.user,
        email: this.email})
        .then(response => {
          const id = response.data.id
          localStorage.setItem('Id', id),
          this.$store.commit('login', token),
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            text:'パスワード再設定しました。',
            time: 5000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: '入力内容に誤りがあります。'
          });
        })
      }
    }


  }

</script>
