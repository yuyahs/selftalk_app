<template>
  <div class="form-overall">
    <h1 class="form-title">
      新しいパスワード設定
    </h1>

    <!-- パスワード再設定フォーム -->
    <input type="hidden" :value="email">

    <label for="user_password">新しいパスワード</label>
    <input type="password" v-model="user.password" class="form-column">

    <label for="user_password_confirmation">パスワード再入力</label>
    <input type="password" v-model="user.password_confirmation" class="form-column">

    <div class="btn-div">
      <button @click="setNewPassword" class="form-btn">
        再設定
      </button>
    </div>

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
