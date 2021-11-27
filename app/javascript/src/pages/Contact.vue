<template>
  <div class="flex flex-col w-full max-w-md h-full container mx-auto bg-white 　　　　　　　　shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
    <h1 class="text-center text-2xl font-bold">
      お問い合わせ
    </h1>

    <div class="my-4">
      <label for ="inquiry_name">お名前<br>(返信をご希望の場合はメールアドレス)</label>
      <input type="text" v-model="inquiry.name" class="pl-3 h-10 w-full border-solid border-2 rounded border-gray-600">
    </div>

    <!-- 問い合わせフォーム -->
    <label for ="inquiry_message">お問い合わせ内容</label>
    <textarea  v-model="inquiry.message" class="content-center resize-none text-2xl h-36 pl-3 pt-3 w-full border-solid border-2 rounded border-gray-600" >
    </textarea>

    <button @click="sendInquiry" class="my-10 w-1/2 bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
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
