<template>
  <div class="form-overall">
    <h1 class="form-title">
      ログイン
    </h1>
      <!-- ログインフォーム -->
      <div class="form-p">
        <label for ="session_e-mail">
          メールアドレス
        </label>
        <input type="text" v-model="session.email" class="form-column">
      </div>

      <div class="form-p">
        <label for="session_password">
          パスワード
        </label>
        <router-link to='/password_resets/new' class="password-reset-link">
          (パスワードを忘れた場合)
        </router-link>
        <input type="password" v-model="session.password" class="form-column">
      </div>

      <div class="btn-div">
        <button @click="createSession" class="form-btn" >
         ログイン
        </button>
      </div>
  </div>

</template>

<script>
  import axios from 'axios';
  //CSRFトークン設定
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
      //ログインメソッド
      createSession: function () {
        axios.post('/api/login', {
          session: this.session
        })
        .then(response => {
          const id = response.data.id
          this.$store.commit('setId', id),
          this.$store.commit('login')
          if(id == 1) {                   //管理ユーザー（id:1)の時の動作
            this.$store.commit('admin')
          }
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'Login',
            text:'ログインに成功しました。',
            time: 3000
          });
        })
        .catch((error) => {
          //validationエラー
          if(error.message === "Request failed with status code 400") {
             this.$flashMessage.show({
              type: 'error',
              title: 'ログインに失敗しました',
              text: '入力内容に誤りがある可能性があります',
              time: 3000
            })
           //アカウント有効化前にログインされた場合のエラー
           } if(error.message === "Request failed with status code 401") {
             this.$flashMessage.show({
              type: 'error',
              title: 'ログインに失敗しました',
              text: 'アカウントが有効化されていません',
              time: 3000
           })
          }
        })
      }
    }
  }
</script>
