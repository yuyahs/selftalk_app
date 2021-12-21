<template>
  <div class="contact-wrapper">
    <h1 class="form-title">
      お問い合わせ
    </h1>

    <div class="contact-name">
      <label for ="inquiry_name">お名前<br>(返信をご希望の場合はメールアドレス)</label>
      <input type="text" v-model="inquiry.name" class="form-column">
    </div>

    <!-- 問い合わせフォーム -->
    <label for ="inquiry_message">お問い合わせ内容</label>
    <textarea  v-model="inquiry.message" class="contact-content" >
    </textarea>

    <button @click="sendInquiry" class="form-btn">
      送信する
    </button>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Contact',
    data() {
      return {
        inquiry: {
          name: "",
          message: ""
        }
      }
    },
    methods: {
      //問い合わせ送信メソッド
      sendInquiry: function (){
        axios.post('/api/contacts',{
          inquiry: this.inquiry
        })
        .then(response => {
          this.$flashMessage.show({
            type: 'success',
            title: '問い合わせ送信',
            text:'問い合わせ内容の送信が完了しました',
            time: 3000
          });
          this.inquiry = ""
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: '入力内容に誤りがあります',
            time: 3000
          });
        })
      }
    }
  }
</script>
