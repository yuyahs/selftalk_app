<template>
  <div class="text-white">
    <h1 class="admin-title">管理画面</h1>
    <div class="text-center text-white border border-solid border-white">
      <h2 class="text-center font-bold text-2xl my-8">{{courseTitle}}</h2>
      <div class="flex flex-row mb-10">
        <p class="mt-2">出題モード一覧▶︎</p>
        <div class="flex flex-row">
          <button @click="showQuestions1">
            <img src="/assets/explain.svg" class="course-small-icon">
          </button>
          <button @click="showQuestions2">
            <img src="/assets/reaction.svg" class="course-small-icon">
          </button>
          <button @click="showQuestions3">
            <img src="/assets/translation.svg" class="course-small-icon">
          </button>
        </div>
      </div>

      <div v-for="question in questions" class="mx-auto pt-1 h-12 w-1/2 bg-white text-2xl text-black m-4 border border-solid border-black rounded" :key="question">
        <li class="list-none">{{question.content}}
        <button @click="deleteQuestion(question.id)" class="underline mr-4 float-right  hover:text-blue-300 ">削除</button></li>
      </div>
    </div>

    <QuestionNew />
    <UserIndex />
  </div>

</template>

<script>
  import axios from 'axios';
  import QuestionNew from './New.vue';
  import UserIndex from '../users/Index.vue';

  export default {
    name: 'Questions',
    components: {
      QuestionNew,
      UserIndex
    },
    data() {
      return {
        questions: "",
        courseTitle: "出題問題集"

      }
    },
    methods: {
      showQuestions1: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions1
        })
      },
      showQuestions2: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions2
        })
      },
      showQuestions3: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions3
        })
      },
      deleteQuestion: function(id) {
        axios.delete('/api/questions/' + id)
        .then(response => {
         location.reload()
        .catch(err => {
            this.$flashMessage.show({
              type: 'error',
              text: '削除に失敗しました',
              time: 5000
            });
        })
      })
     }
   }
  }





</script>
