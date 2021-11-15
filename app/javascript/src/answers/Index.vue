<template>
  <div class="text-center items-center justify-center mt-12">
    <h1 class="mb-4 font-bold text-2xl text-white">回答集</h1>
    <ul v-for="answer in answers" class="mb-24 break-words h-28 bg-white list-none text-2xl border border-solid border-black rounded-lg" :key="answer">
      <span class="float-right text-lx border border-solid border-black shadow-xl hover:bg-blue-300">
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" >
        添削する
      </router-link></span>
      <li class="w-1/2 text-left pl-4 pt-8">{{answer.content}}</li>
    </ul>
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


