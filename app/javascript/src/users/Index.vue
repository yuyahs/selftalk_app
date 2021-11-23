<template>
  <div class="text-white text-center border border-solid border-white">
    <h1 class="admin-title">Userリスト</h1>
    <h2 class="text-xl">User数：{{users.length}}</h2>
    <li v-for="user in users" :key="user" class="user-list">{{user.name}}</li>

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
    showUsers: function() {
      axios.get('/api/users')
      .then(response => {
          this.users = response.data
        })
    }
  }
}
</script>
