<template>
  <div class="text-center">
     <div class="text-white mb-10">
        <progress id="progress" value="45" max="45" class="bg-white w-1/2 border border-solid border-white rounded-full"></progress>
        <span id="countdown">45</span>
    </div>
     <div class="text-2xl w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg px-8 pt-6 pb-8 mb-4">
       <div>{{question.content}}</div>
     </div>

     <input type="hidden" :value="mode_num">
     <input type="hidden" :value="id">

     <textarea id="text1" v-model="answer.content" class="content-center resize-none text-2xl h-36 pl-3 pt-3 w-full border-solid border-2 rounded border-gray-600" >
     </textarea>

     <button @click="saveAnswer" class="my-10 bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
      次の問題へ進む
     </button>
     <router-link to="/" class="ml-4 my-10 bg-white hover:bg-blue-500 text-blue-500 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">
      終了する
     </router-link>
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
        mode_num: this.$route.query.mode_num
      }
    },
    mounted() {
      this.setQuestion();
      this.setTimer();
    },
    methods: {
      setQuestion: function () {
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
          this.$router.go({path: this.$router.currentRoute.path})
        })
         .catch(err => {
            this.$router.go({path: this.$router.currentRoute.path})
         })
      },
      setTimer: function() {
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
     }

    }
  }





</script>

<style scoped>
  #progress::-webkit-progress-bar {
  border-radius: 15px;
  background-color: #D1D5DB;
  }

  #progress::-webkit-progress-value {
    border-radius: 15px;
    background-color: #3B82F6;

  }

  #progress::-moz-progress-bar {
    border-radius: 15px;
    background-color: #3B82F6;

  }

  #progress::-ms-fill {
    border-radius: 15px;
    background-color: #3B82F6;
  }
</style>
