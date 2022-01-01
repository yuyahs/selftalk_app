<template>
  <div class="form-overall">
    <h1 class="form-title">
      登録情報を変更する
    </h1>

    <!-- 登録情報変更フォーム -->
    <input type="hidden" :value="user.id">
    <div class="form-p">
      <label for ="user_name"> ユーザーネーム</label>
      <input type="text" v-model="user.name" class="form-column">
    </div>
    <div class="form-p">
      <label for ="user_e-mail"> メールアドレス</label>
      <input type="text" v-model="user.email" class="form-column">
    </div>
    <div class="form-p">
      <label for="user_password"> パスワード(6文字以上) </label>
      <input type="password" v-model="user.password" class="form-column">
    </div>
    <div class="form-p">
      <label for="user_password_confirmation"> パスワード再入力 </label>
      <input type="password" v-model="user.password_confirmation" class="form-column">
    </div>

    <div class="btn-div">
      <button @click="saveEditedInfo" class="form-btn" >
        変更情報を保存
      </button>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  export default {
    name: 'userEdit',
    data() {
      return {
        user:
          "users"
      }
    },
    mounted() {
      this.getUserInfo();
      this.mksureCorrectUser();
      this.mksureNotGuestUser();
    },
    methods: {
      //ログイン中のユーザー情報を取得するメソッド
      getUserInfo: function() {
        axios.get(`/api/users/${this.$route.params.id}/edit`)
        .then(response => (
        this.user = response.data
        ))
      },
      //ユーザー情報の変更を保存するメソッド
      saveEditedInfo: function () {
        axios.patch(`/api/users/${this.$route.params.id}`, {
        user: this.user
        })
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ユーザー情報変更',
            text:'ユーザー情報を変更しました',
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
      },
      mksureCorrectUser: function(){
        const currentUserId = this.$store.state.userId
        if(!(currentUserId == this.$route.params.id)){
          this.$router.push({name: 'home'})
        }
      },
      mksureNotGuestUser: function() {
        if(this.$store.state.guest){
          this.$router.push({name: 'home'})
        }
      }
    }
  }
</script>
