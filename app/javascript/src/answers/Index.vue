<template>
  <div class="answer-index-wrapper">
    <h1 class="content-title">
      回答集
    </h1>
    <MyMenu />

    <!-- 回答一覧を表示 -->
    <div v-for="answer in answers" class="answers" :key="answer">
      <textarea v-model="answer.content" disabled class="answer-text-content">
      </textarea>
      <li @click="linkToAnswerEdit(answer.id)" class="edit-btn">
         添削する
      </li>
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
        answers: ""
      }
    },
    mounted() {
      this.getAnswers();
      this.checkCorrectUser();
      this.checkNotGuestUser();
    },
    methods: {
      //特定日付のanswer一覧のデータを受け取るメソッド
      getAnswers: function() {
        axios.get(`/users/${this.$route.params.id}/api/answers`, {
          params: {
            created_at: this.$route.query.created_at
          }
        })
        .then(response => {
          this.answers = response.data.answers
        })
      },
      linkToAnswerEdit: function(answerId) {
        const id = localStorage.getItem('userId')
        this.$router.push({ path: `/users/${id}/answers/${answerId}/edit`})
      },
      checkCorrectUser: function() {
        const currentUserId = localStorage.getItem('userId')
        if(!(currentUserId == this.$route.params.id)){
          this.$router.push({name: 'home'})
        }
      },
      checkNotGuestUser: function() {
        if(this.$store.state.guest){
          this.$router.push({name: 'home'})
        }
      }
    }
  }
</script>


