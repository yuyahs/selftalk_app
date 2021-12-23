<template>
  <div class="txt-white">
    <h1 class="form-title">運営からのお知らせ一覧</h1>

    <div>
      <li v-for="notice in notices" :key="notice">{{notice.title}}</li>
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
