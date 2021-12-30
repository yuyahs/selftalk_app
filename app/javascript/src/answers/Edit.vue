<template>
  <div class="answer-edit-wrapper">

    <MyMenu />

    <h1 class="question-display">
      {{question.content}}
    </h1>

    <textarea v-model="answer.content" class="answer-input-form" >
    </textarea>

    <button @click="saveEditedAnswer" class="edit-save-btn">
      添削内容を保存する
    </button>

    <router-link :to="{name: 'answers', params: {id: $store.state.userId},
    query: {created_at: date}}" class="to-answer-index-btn">
    　回答一覧に戻る
  　</router-link>
  </div>

</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu.vue'
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
        date: ""
      }
    },
    mounted() {
      this.getInfoAboutAnswer();
      this.mksureCorrectUser();
      this.mksureNotGuestUser();
    },
    methods: {
      getInfoAboutAnswer: function () {
        axios.get(`/users/${this.$store.state.userId}/api/answers/
        ${this.$route.params.id}/edit`)
        .then(response => {
          this.question = response.data.question
          this.answer= response.data
          this.date = response.data.date
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
      mksureCorrectUser: function(){
        const currentUserId = this.$store.state.userId
        if(!(currentUserId == this.$route.params.user_id)){
          this.$router.push({name: 'home'})
        }
      },
      mksureNotGuestUser: function() {
        if(this.$store.state.guest){
          this.$router.push({name: 'home'})
        }
      }
    }
  }
</script>
