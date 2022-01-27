<template>
  <div class="answer-edit-wrapper">

    <MyMenu />

    <h1 class="from-course-name">
      From {{course}}
    </h1>
    <h2 class="question-display">
      Q. {{question.content}}
    </h2>

    <textarea v-model="answer.content" class="answer-input-form" >
    </textarea>

    <button @click="saveEditedAnswer" class="edit-save-btn">
      添削内容を保存する
    </button>

    <router-link :to="{name: 'answers', params: {id: $store.state.userId},
    query: {created_at: date}}" class="to-answer-index-btn">
    　回答一覧に戻る
  　</router-link>
<!-- 
   <button @click="translateWithDeepL" class="edit-save-btn">翻訳する</button>
   <h3 class="result">結果を表示：{{result}}</h3> -->
  </div>
</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu.vue'
  import Export from '../shared/exports';

  export default {
    name: 'AnswerEdit',
    components: {
      MyMenu
    },
    data: function () {
      return {
        question: {
          content: ""
        },
        answer: {
          content: ""
        },
        course: "",
        date: "",
        result: "",

      }
    },
    mounted() {
      this.getInfoAboutAnswer();
      Export.mksureCorrectUser(this.$route.params.user_id);
      Export.mksureNotGuestUser();
    },
    methods: {
      getInfoAboutAnswer: function () {
        axios.get(`/users/${this.$store.state.userId}/api/answers/
        ${this.$route.params.id}/edit`)
        .then(response => {
          this.question = response.data.question
          if(this.question.mode_num == 1) {
            this.course = "Self Explain"
          } if (this.question.mode_num == 2) {
            this.course = "Self Reaction"
          } if (this.question.mode_num == 3) {
            this.course = "Self translation"
          }
          this.answer= response.data
          this.date = response.data.date
          this.deeplApiKey = response.data.deeplKey
        })
      },
      saveEditedAnswer: function() {
        if(window.confirm('変更内容を保存しますか？')) {
          axios.patch(`/api/answers/${this.$route.params.id}`, {
          answer: this.answer
          })
          .then(response => {
            this.$flashMessage.show({
              type: 'success',
              title: '添削保存',
              text: '変更を保存しました',
              time: 3000
            });
          })
        }
      },
      translateWithDeepL: function() {
        axios.get('/api/translate')
        .then(response => {
          this.result = response.data.translations[0].text
          console.log(response.data.translations[0].text)
        })
      }
    }
  }
</script>
