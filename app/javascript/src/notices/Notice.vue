<template>
  <div class="notice-index-wrapper">
    <h1 class="notices-title">お知らせ</h1>
  



  </div>

</template>

<script>
 import axios from 'axios';

 export default {
  name: 'Notice',
  data() {
    return {
      notice: {
        content: ""
      }
    }
  },
  // mounted() {
  //   this.showNotice();
  // },
  methods: {
    showNotice: function () {
      axios.get(`/api/notice/${this.$route.params.id}`)
      .then(response => {
        this.notice.content = response.data
      })
    }
  }


}
</script>
