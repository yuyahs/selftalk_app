<template>
  <div class="admin-section-wrapper">
    <h1 class="admin-title">
      お知らせ作成
    </h1>
    <div class="notice-new-prop">
      <label for ="notice_title">タイトル</label>
      <input type="text" v-model="notice.title" class="new-notice-title">
      <label for ="notice_content">内容</label>
      <textarea v-model="notice.content" class="new-notice-content"></textarea>

      <button @click="createNotice" class="model-save-btn">
        通知する
      </button>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'NoticeNew',
    data() {
      return {
        notice: {
          title: "",
          content: ""
        }
      }
    },
    methods: {
      // noticeを作成するメソッド
      createNotice: function () {
        axios.post('/api/notices', {
          notice: this.notice
        })
        .then(response => {
          this.$flashMessage.show({
            type: 'success',
            title: 'お知らせ作成',
            text:'お知らせを通知しました',
            time: 3000
          });
          this.notice.title=""
          this.notice.content=""
          this.$store.commit('notifyNotice')
        })
        .catch(err => {
          this.$flashMessage.show({
            type: 'error',
            text: '作成に失敗しました',
            time: 3000
          });
        })
     　}
    }
  }
</script>
