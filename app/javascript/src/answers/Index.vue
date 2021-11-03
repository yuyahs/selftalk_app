<template>
  <div class="text-center items-center justify-center mt-12">
    <h1 class="mb-4 font-bold text-2xl text-white">回答集</h1>
    <div v-for="answer in answers" class="mb-24 break-words h-32 bg-white list-none text-2xl border border-solid border-black rounded-lg" :key="answer">
      <li class="mb-32">{{answer.content}}</li>
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" class="my-28 bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
        添削する
      </router-link>
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


