<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8">
    <h1 class="text-center font-bold text-2xl mb-6">
      パスワード再設定リンクを送信する
    </h1>

    <!-- パスワードリセットリンク送信フォーム -->
    <label for="password_reset_email">メールアドレス</label>
    <input type="email"  v-model="password_reset.email" class= "pl-3 h-10 w-full border-solid border-2 rounded border-gray-600" >
    <div class="flex flex-row">
      <button @click="sendResetForm" class="w-1/2 mt-4 bg-blue-500  text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-white rounded-full" >
       送信
      </button>
    </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Reset',
    data() {
      return {
        password_reset: {
          email: '',
        }
      }
    },
    methods: {
      //パスワードリセットフォーム送信メソッド
      sendResetForm: function () {
        axios.post('/api/password_resets', {
          password_reset: this.password_reset
        })
        .then(response => {
         this.$router.push({ path: '/'}),
         this.$flashMessage.show({
          type: 'success',
          title: 'パスワードリセット',
          text:'パスワード再設定用リンクを送信しました',
          time: 3000
         });
        })
        .catch(error => {
          this.$router.push({path: '/password_resets/new'}),
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
