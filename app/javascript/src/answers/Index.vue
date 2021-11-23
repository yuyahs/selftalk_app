<template>
  <div class="items-center justify-center">
    <h1 class="font-bold text-2xl text-center text-white">回答集</h1>
    <MyMenu />
    <div v-for="answer in answers" class="answers" :key="answer">
      <li v-for="question in questions" :key="question" class="question-content">
        Q, {{question.content}}
        <textarea v-model="answer.content" disabled class="answer-text-content"></textarea>
      </li>
      <li class="edit-btn">
       <router-link :to="{name: 'answerEdit', params: {id: answer.id}}">
        添削する
      </router-link></li>
    </div>
  </div>

</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu.vue'

  export default {
    name: 'Answers',
    components: {
      MyMenu
    },
    data() {
      return {
        answers: "",
        questions: ""
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
          this.answers = response.data.answers
          this.questions = response.data.questions
          console.log(response.data)
        })
      }
    }
  }





</script>


