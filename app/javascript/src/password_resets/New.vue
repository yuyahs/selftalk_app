<template>
  <div class="form-overall">
    <h1 class="form-title">
      パスワード再設定
    </h1>

    <!-- パスワードリセットリンク送信フォーム -->
    <label for="password_reset_email">メールアドレス</label>
    <input type="email"  v-model="password_reset.email" class= "form-column" >
    <div class="btn-div">
      <button @click="sendResetForm" class="form-btn" >
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
