<template>
  <div class="text-center text-white">
    <div class="flex flex-row mb-10">
     <p class="mt-2">出題モード一覧▶︎</p>
     <div class="flex flex-row">
       <router-link :to="{ name: 'questions', query: {mode_num: 1}}" @click="showQuestions">
         <img src="/assets/explain.svg" class="ml-4 w-12 h-12 object-cover border border-solid border-white rounded-full hover:bg-white">
       </router-link>
       <router-link :to="{ name: 'questions', query: {mode_num: 2}}" @click="showQuestions">
         <img src="/assets/reaction.svg" class="ml-4 w-12 h-12 object-cover border border-solid border-white rounded-full hover:bg-white">
       </router-link>
     </div>
    </div>

    <ul class="mb-8 text-2xl">
      <li>{{courseTitle}}</li>
    </ul>

    <div v-for="question in questions" class="mx-auto pt-1 h-12 w-1/2 bg-white text-2xl text-black m-4 border border-solid border-black rounded" :key="question">
      <li class="list-none">{{question.content}}
       <button @click="deleteQuestion(question.id)" class="underline mr-4 float-right  hover:text-blue-300 ">削除</button></li>
    </div>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Questions',
    data() {
      return {
        questions: "",
        courseTitle: "Self Explain問題集"

      }
    },
    mounted() {
      this.showQuestions();
    },
    methods: {
      showQuestions: function() {
        axios.get('/api/questions', {
          params: {
            mode_num: this.$route.query.mode_num
          }
        })
        .then(response => {
          this.questions = response.data
          if(this.$route.query.mode_num == 1) {
            this.courseTitle = "Self Explain問題集"
          } if(this.$route.query.mode_num == 2) {
            this.courseTitle = "Self Reaction問題集"
          }
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
