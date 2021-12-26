<template>
  <div class="notice-wrapper">
    <h1 class="notice-title">運営からのお知らせ一覧</h1>

    <div class="all-notices">
      <li v-for="notice in notices" :key="notice" class="notice-list">
        {{notice.created_at.substr(0,10)}}
        <router-link :to="{ name: 'notice', params: {id: notice.id}}" class="notice-list-title">{{notice.title}}</router-link>
      </li>
    </div>
  </div>

</template>

<script>
 import axios from 'axios';

 export default {
  name: 'Notices',
  data() {
    return {
      notices: ""
    }
  },
  mounted() {
    this.getNotices();
  },
  methods: {
    getNotices: function() {
      axios.get('/api/notices')
      .then( response => {
        this.notices = response.data.notices
      })
    }
  }


}
</script>
