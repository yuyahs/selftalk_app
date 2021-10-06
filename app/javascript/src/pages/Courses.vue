<template>
  <span @click="destroySession">ログアウト</span>
</template>

<script>

import axios from 'axios';

export default {
  name: 'Courses',

  methods: {
     destroySession: function() {
        axios.post('/api/logout')
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ログアウト',
            text:'ログアウトしました',
            time: 5000
          });
        })
      }
  }
}
</script>
