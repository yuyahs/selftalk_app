<template>
  <div class="admin-section-wrapper">
    <h1 class="admin-title">
      Userリスト
    </h1>
    <!-- userの数を表示する -->
    <h2 class="user-num">
      User数：{{users.length}}
    </h2>

    <!--user一覧を表示する -->
    <li v-for="user in users" :key="user" class="user-list">
      {{user.name}} : {{user.email}}
    </li>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserIndex',
  data() {
    return {
      users: ""
    }
  },
  mounted() {
    this.showUsers()
  },
  methods: {
    //user一覧を取得するメソッド
    showUsers: function() {
      axios.get('/api/users')
      .then(response => {
        this.users = response.data
      })
    }
  }
}
</script>
