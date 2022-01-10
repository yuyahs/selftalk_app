<template>
  <div class="answer-index-wrapper">
    <h1 class="content-title">
      回答集
    </h1>
    <MyMenu />

    <section v-for="answer in answers" class="answers" :key="answer">
      <div class="answer-text-content">
        {{answer.content}}
      </div>
      <li class="edit-btn">
       <router-link :to="{name: 'answerEdit', params: {user_id: $store.state.userId,
       id: answer.id}}">
         添削する
       </router-link>
      </li>
    </section>
  </div>
</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu.vue'
  import Export from '../shared/exports';

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
      this.getAnswersOnTheDate();
      Export.mksureCorrectUser(this.$route.params.id);
      Export.mksureNotGuestUser();
    },
    methods: {
      getAnswersOnTheDate: function() {
        axios.get(`/users/${this.$route.params.id}/api/answers`, {
          params: {
            created_at: this.$route.query.created_at
          }
        })
        .then(response => {
          this.answers = response.data.answers
        })
      }
    }
  }
</script>

