<template>
  <div class="text-white">
    <h1 class="admin-title">
      管理画面
    </h1>
    <div class="text-center border border-solid border-white">
      <h2 class="text-center font-bold text-2xl my-8">
        {{courseTitle}}
      </h2>
      <!-- 出題文一覧 -->
      <div class="flex flex-row mb-10">
        <p class="mt-2">
          出題モード一覧▶︎
        </p>
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

      <!-- 出題文削除ボタン -->
      <div v-for="question in questions" class="question-list" :key="question">
        <li class="list-none">
          {{question.content}}
          <button @click="deleteQuestion(question.id)" class="question-delete">
            削除
          </button>
        </li>
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
      //explainモード用のquestionを取得するメソッド
      showQuestions1: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions1
        })
      },
      //rectionモード用のquestionを取得するメソッド
      showQuestions2: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions2
        })
      },
      //translateモード用のquestionを取得するメソッド
      showQuestions3: function() {
        axios.get('/api/questions')
        .then(response => {
          this.questions = response.data.questions3
        })
      },
      //questionを削除するメソッド
      deleteQuestion: function(id) {
        axios.delete('/api/questions/' + id)
        .then(response => {
         location.reload()
        .catch(err => {
            this.$flashMessage.show({
              type: 'error',
              text: '削除に失敗しました',
              time: 3000
            });
         })
       })
      }
    }
   }
</script>
