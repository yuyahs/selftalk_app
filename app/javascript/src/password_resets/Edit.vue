<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">
      新しいパスワードを設定する
    </h1>

    <!-- パスワード再設定フォーム -->
    <input type="hidden" :value="email">

    <label for="user_password">新しいパスワード</label>
    <input type="password" v-model="user.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">

    <label for="user_password_confirmation">パスワード再入力</label>
    <input type="password" v-model="user.password_confirmation" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">

    <button @click="setNewPassword" class="w-1/2 bg-blue-500  text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-white rounded-full mt-8">
      再設定
    </button>

 </div>

</template>

<script>
  import axios from 'axios';

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
      //パスワード再設定メソッド
      setNewPassword: function () {
        axios.patch(`/api/password_resets/${this.$route.params.reset_token}`, {
        user: this.user,
        email: this.email})
        .then(response => {
          const id = response.data.id
          this.$store.commit('setId', id),
          this.$store.commit('login'),
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'パスワード再設定',
            text:'パスワード再設定しました。',
            time: 3000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: '入力内容に誤りがあります',
            time: 3000
          });
        })
      }
    }


  }

</script>
