<template>
  <div class="items-center justify-center">
    <h1 class="font-bold text-2xl text-center text-white">回答集</h1>
    <div v-for="answer in answers" class="break-words my-8 h-28 bg-white list-none text-2xl border-t border-solid border-black rounded-lg" :key="answer">
      <li class="float-right text-lx text-white border border-solid border-black shadow-xl bg-red-500 hover:bg-red-300">
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" >
        添削する
      </router-link></li>
      <li class="text-left text-2xl w-full">{{answer.content}}</li>
    </div>

    <div class="text-center mt-64">
      <button class="underline bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white p-4 border border-blue-500"><router-link to="/" >
        コース一覧へ</router-link>
      </button>
    </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Answers',
    data() {
      return {
        answers: "",
      }
    },
    mounted() {
      this.getAnswers();
    },
    methods: {
      getAnswers: function() {
        axios.get('api/answers', {
          params: {
            created_at: this.$route.query.created_at
          }
        })
        .then(response => {
          this.answers = response.data
        })
      }
    }
  }





</script>


