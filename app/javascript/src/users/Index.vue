<template>
  <div class="text-white text-center border border-solid border-white">
    <h1 class="font-bold text-2xl my-8">Userリスト</h1>
    <h2 class="text-xl">User数：{{users.length}}</h2>
    <section v-for="user in users" :key="user" class="list-none my-8">
      <li class="underline mb-4">{{user.name}}</li>
    </section>
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
