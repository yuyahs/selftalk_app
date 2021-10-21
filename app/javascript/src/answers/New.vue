<template>
  <div>
    <p>courses</p>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {

    name: 'Courses',
  }
  //   data() {
  //     return {
  //       user: {
  //         name: '',
  //         email: '',
  //         password: '',
  //         password_confirmation: '',
  //       }
  //     }
  //   },
  //   methods: {
  //     createUser: function () {
  //       axios.post('/api/users', {
  //         user: this.user
  //       })
  //       .then(response => {
  //         const userId = localStorage.getItem('Id')
  //         if (userId) {
  //           localStorage.removeItem('Id')
  //         }
  //         const id = response.data.id
  //         localStorage.setItem('Id', id),
  //         this.$router.push({ path: '/'}),
  //         this.$flashMessage.show({
  //           type: 'success',
  //           title: 'ユーザー登録が完了しました。',
  //           text:'アカウント有効化メールを送信しました。',
  //           time: 5000
  //         });
  //       })
  //       .catch(err => {
  //           this.$router.push({ path: '/users/new'}),
  //           this.$flashMessage.show({
  //             type: 'error',
  //             title: 'ユーザー登録に失敗しました',
  //             text: '入力内容に誤りがある可能性があります。',
  //             time: 5000
  //           });
  //       })
  //     }
  //   }



</script>
