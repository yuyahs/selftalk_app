<template>
  <div class="notice-wrapper">
    <h1 class="notice-title">お知らせ（{{notice.created_at.substr(0,10)}}):
      {{notice.title}}
    </h1>
    <div class="notice-content-wrapper">
      <p class="notice-content">{{notice.content}}</p>
    </div>

    <button class="link-to-notices">
      <router-link :to='{ name: "notices"}'>
        お知らせ一覧に戻る
      </router-link>
    </button>
  </div>
</template>

<script>
 import axios from 'axios';
 import Export from '../shared/exports';

 export default {
  name: 'Notice',
  data() {
    return {
      notice: {
        title: "",
        content: "",
        created_at: ""
      }
    }
  },
  mounted() {
    this.showNotice();
    Export.mksureNotGuestUser();
  },
  methods: {
    showNotice: function () {
      axios.get(`/api/notices/${this.$route.params.id}`)
      .then(response => {
        this.notice = response.data
      })
    }
  }
}
</script>
