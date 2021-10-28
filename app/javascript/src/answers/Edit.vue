<template>
  <div class="text-center items-center justify-center ">

    <h1 class="text-2xl w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">{{question.content}}</h1>

    <input type="text" v-model="answer.content" class="content-center text-2xl h-36 pl-3 w-full border-solid border-2 rounded border-gray-600">

    <button @click="editAnswer" class="ml-4 my-10 bg-white hover:bg-blue-500 text-blue-500 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
    添削内容を保存する</button>

    <router-link :to="{name: 'answers', query: {created_at: date}}" class="ml-4 my-10 bg-white hover:bg-blue-500 text-blue-500 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
    　回答一覧に戻る
  　</router-link>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'AnswerEdit',
    data: function () {
      return {
        question: {
          content: ""
        },
        answer: {
          content: ""
        },
        date: ""
      }
    },
    mounted() {
      this.getAnswer();
    },
    methods: {
      getAnswer: function () {
        axios.get(`/api/answers/${this.$route.params.id}/edit`)
        .then(response => {
          this.question = response.data.question
          this.answer= response.data
          this.date = response.data.date
        })
      },
      editAnswer: function() {
        axios.patch(`/api/answers/${this.$route.params.id}`, {
        answer: this.answer
        })
        .then(response => {
          this.$router.push({ path: location.pathname}),
          this.$flashMessage.show({
            type: 'success',
            text:'回答の変更を保存しました。',
            time: 5000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: '入力内容に誤りがあります。'
          });
        })
      }
    }
  }
</script>
