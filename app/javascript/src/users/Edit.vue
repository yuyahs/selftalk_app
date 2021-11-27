<template>
 <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center font-bold text-2xl mb-6">
      登録情報を変更する
    </h1>

    <!-- 登録情報変更フォーム -->
    <input type="hidden" :value="user.id">
    <div class="form-p">
      <label for ="user_name"> ユーザーネーム</label>
      <input type="text" v-model="user.name" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
    </div>
    <div class="form-p">
      <label for ="user_e-mail"> メールアドレス</label>
      <input type="text" v-model="user.email" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
    </div>
    <div class="form-p">
      <label for="user_password"> パスワード(6文字以上) </label>
      <input type="password" v-model="user.password" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
    </div>
    <div class="form-p">
      <label for="user_password_confirmation"> パスワード再入力 </label>
      <input type="password" v-model="user.password_confirmation" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
    </div>

    <button @click="editInfo" class="w-1/2 mt-4 bg-blue-500  text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-white rounded-full" >
      変更情報を保存する
    </button>
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
      }
    }
  }
</script>
