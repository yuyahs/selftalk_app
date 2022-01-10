<template>
  <div class="notice-wrapper">
    <h1 class="notice-title">運営からのお知らせ一覧</h1>

    <div class="all-notices">
      <li v-for="notice in notices" :key="notice" class="notice-list">
        {{notice.created_at.substr(0,10)}} <!--日付以外の余分な部分を表示しないため-->
        <router-link :to="{ name: 'notice', params: {id: notice.id}}" class="notice-list-title">{{notice.title}}</router-link>
        <button v-if="$store.state.admin" class="delete-notice"
        @click="deleteNotice(notice.id)">
          削除
        </button>

      </li>
    </div>
  </div>
</template>

<script>
 import axios from 'axios';
 import Export from '../shared/exports';

 export default {
  name: 'Notices',
  data() {
    return {
      notices: ""
    }
  },
  mounted() {
    this.getAllNotices();
    Export.mksureNotGuestUser();
  },
  methods: {
    getAllNotices: function() {
      axios.get('/api/notices')
      .then( response => {
        this.notices = response.data.notices
      })
    },
    deleteNotice: function(id) {
      if(window.confirm('削除してよろしいですか？')) {
        axios.delete('/api/notices/' + id)
        .then(response => {
          location.reload()
          .catch(err => {
            this.$flashMessage.show({
              type: 'error',
              text: '削除に失敗しました',
              time: 3000
            });
          })
        })
      }
    }
  }
}
</script>
