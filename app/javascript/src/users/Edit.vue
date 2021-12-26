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
      <button @click="editInfo" class="form-btn" >
        変更情報を保存する
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
      this.setUser();
      this.checkCorrectUser();
      this.checkNotGuestUser();
    },
    methods: {
      //ログイン中のユーザー情報を取得するメソッド
      setUser: function() {
        axios.get(`/api/users/${this.$route.params.id}/edit`)
        .then(response => (
        this.user = response.data
        ))
      },
      //ユーザー情報の変更を保存するメソッド
      editInfo: function () {
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
      checkCorrectUser: function(){
        const currentUserId = localStorage.getItem('userId')
        if(!(currentUserId == this.$route.params.id)){
          this.$router.push({name: 'home'})
        }
      },
      checkNotGuestUser: function() {
        if(this.$store.state.guest){
          this.$router.push({name: 'home'})
        }
      }
    }
  }
</script>
