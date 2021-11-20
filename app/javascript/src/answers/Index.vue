<template>
  <div class="items-center justify-center">
    <h1 class="font-bold text-2xl text-center text-white">回答集</h1>
    <MyMenu />
    <div v-for="answer in answers" class="answers" :key="answer">
      <li class="edit-btn">
      <router-link :to="{name: 'answerEdit', params: {id: answer.id}}" >
        添削する
      </router-link></li>
      <li class="text-left text-2xl w-full pl-2">{{answer.content}}</li>
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


