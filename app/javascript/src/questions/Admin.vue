<template>
  <div class="txt-white">
    <h1 class="admin-title">
      管理画面
    </h1>
    <div class="admin-section-wrapper">
      <h2 class="admin-section-title">
        出題問題集
      </h2>
      <!-- 出題文一覧 -->
      <div class="icons-wrapper">
        <p class="icons-title">
          出題モード一覧▶︎
        </p>
        <div>
          <button @click="showQuestions1">
            <img src="../assets/explain.svg" class="course-small-icon">
          </button>
          <button @click="showQuestions2">
            <img src="../assets/reaction.svg" class="course-small-icon">
          </button>
          <button @click="showQuestions3">
            <img src="../assets/translation.svg" class="course-small-icon">
          </button>
        </div>
      </div>

      <!-- 出題文一覧 -->
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
        questions: ""
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
