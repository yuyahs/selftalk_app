<template>
  <div class="text-center items-center justify-center">
    <h1 class="mb-4 font-bold text-2xl text-white">回答集</h1>
    <div v-for="answer in answers" class="my-24 break-words h-28 bg-white list-none text-2xl border border-solid border-black rounded-lg" :key="answer">
      <li class="float-right text-lx border border-solid border-black shadow-xl hover:bg-blue-300">
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" >
        添削する
      </router-link></li>
      <li class="w-1/2 text-left py-8 pl-4">{{answer.content}}</li>
    </div>

    <div class="text-center">
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


