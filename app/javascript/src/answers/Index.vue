<template>
  <div class="items-center justify-center">
    <h1 class="font-bold text-2xl text-center text-white">
      回答集
    </h1>
    <MyMenu />

    <!-- 回答一覧を表示 -->
    <div v-for="answer in answers" class="answers" :key="answer">
      <textarea v-model="answer.content" disabled class="answer-text-content"></textarea>
      <li class="edit-btn">
       <router-link :to="{name: 'answerEdit', params: {user_id: $store.state.userId,
       id: answer.id}}">
         添削する
       </router-link>
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
      this.correctUser();
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
      correctUser: function(){
      const currentUserId = this.$store.state.userId
      if(!(currentUserId == this.$route.params.id)){
        this.$router.push({name: 'home'})
      }
    }
    }
  }
</script>


