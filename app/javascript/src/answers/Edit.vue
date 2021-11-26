<template>
  <div class="text-center items-center justify-center">

    <MyMenu />

    <!-- 出題文を表示 -->
    <h1 class="text-2xl w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
      {{question.content}}
    </h1>

    <!-- answerを表示 -->
    <textarea v-model="answer.content" class="content-center resize-none text-2xl h-36 pl-3 pt-3 w-full border-solid border-2 rounded border-gray-600" >
    </textarea>

    <!-- 添削を保存するボタン -->
    <button @click="editAnswer" class="ml-4 my-10 bg-blue-500 text-white font-semibold hover:bg-blue-300 py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
      添削内容を保存する
    </button>

   <!--回答一覧に戻るボタン-->
    <router-link :to="{name: 'answers', query: {created_at: date}}" class="ml-4 my-10 bg-white hover:bg-blue-500 text-blue-500 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
    　回答一覧に戻る
  　</router-link>
  </div>

</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu.vue'

  export default {
    name: 'AnswerEdit',
    components: {
      MyMenu
    },
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
      //answerのデータを受け取るメソッド
      getAnswer: function () {
        axios.get(`/api/answers/${this.$route.params.id}/edit`)
        .then(response => {
          this.question = response.data.question
          this.answer= response.data
          this.date = response.data.date
        })
      },
      //answerの編集内容を保存するメソッド
      editAnswer: function() {
        axios.patch(`/api/answers/${this.$route.params.id}`, {
        answer: this.answer
        })
      }
    }
  }
</script>
