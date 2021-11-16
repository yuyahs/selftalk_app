<template>
  <div class="items-center justify-center">
    <h1 class="font-bold text-2xl text-center text-white">回答集</h1>
    <div v-for="answer in answers" class="answers" :key="answer">
      <li class="edit-btn">
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" >
        添削する
      </router-link></li>
      <li class="text-left text-2xl w-full">{{answer.content}}</li>
    </div>

    <div class="course-btn">
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


