<template>
  <div class="course-overall">
     <div class="course-progress-wrapper">
        <progress id="progress" value="45" max="45" class="progress-prop"></progress>
        <span id="countdown">45</span>
    </div>
     <div class="question-display">
       <div>{{question.content}}</div>
     </div>

     <input type="hidden" :value="mode_num">
     <input type="hidden" :value="answersCreatedToday">

     <textarea id="text1" v-model="answer.content" class="answer-input-form" >
     </textarea>

     <button @click="saveAnswer" class="next-question-btn">
      次の問題へ進む
     </button>
     <router-link to="/" class="finish-btn">
      終了する
     </router-link>

    <!-- translation courseの時だけ表示する -->
     <div v-if="mode_num == 3">
        <button @click="translateWithDeepL" class="access-deepl-btn">
          AI翻訳の結果を確認する
        </button>
        <h1 class="result">翻訳結果: {{result}}</h1>
     </div>
  </div>


</template>

<script>
  import axios from 'axios';



  export default {
   beforeRouteLeave (to, from, next) {
      next(this.$clearInterval(this.$intervals))
    },
    name: 'Courses',
    data() {
      return {
        question: {
          content: ""
        },
        answer: {
          content: ""
        },
        mode_num: this.$route.query.mode_num,
        answersCreatedToday: "",
        result: ""
      }
    },
    mounted() {
      this.getRandomQuestion();
      this.startTimer();
      this.getAnswersCreatedToday();
    },
    methods: {
      getRandomQuestion: function () {
        axios.get(`/api/answers/new?mode_num=${this.$route.query.mode_num}`)
        .then(response => {
          this.question = response.data
          this.id = response.data.id
        })
      },
      saveAnswer: function() {
        axios.post('/api/answers', {
          answer: this.answer,
          id: this.id,
          mode_num: this.mode_num
        })
        .then(response => {
          this.answer.content = ""
          this.getRandomQuestion();
          this.$clearInterval(this.$intervals);
          this.startTimer();
          //作成されたanswerが本日一個めなら連続学習日数記録を更新する
          if(this.answersCreatedToday === 0){
            this.$store.commit('countSequentialDays')
          }
        })
         .catch(err => {
            this.answer.content = ""
            this.getRandomQuestion();
            this.$clearInterval(this.$intervals);
            this.startTimer();
         })
      },
      startTimer: function() {
        let i = 45;
        this.$setInterval(() => {
          i -- ;
          const doc0 = document.getElementById('countdown');
          doc0.textContent= `${i}`;
          document.getElementById('progress').setAttribute('value', i);
          if(i == 0 ) {
            clearInterval(this.$intervals);
          }
      }, 1000)
     },
     getAnswersCreatedToday: function () {
       axios.get('/api/questions/new')
       .then(response => {
         this.answersCreatedToday = response.data
       })
     },
     //DeepL apiを叩くためのmethod
     translateWithDeepL: function() {
       const question_id = this.question.id
        axios.get('/api/translate/'+ question_id)
        .then(response => {
          this.result = response.data.translations[0].text
        })
      }
    }
  }
</script>


