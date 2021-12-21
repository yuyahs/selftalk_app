<template>
  <div class="answer-edit-wrapper">

    <MyMenu />

    <!-- 出題文を表示 -->
    <h1 class="question-display">
      {{question.content}}
    </h1>

    <!-- answerを表示 -->
    <textarea v-model="answer.content" class="answer-input-form" >
    </textarea>

    <!-- 添削を保存するボタン -->
    <button @click="editAnswer" class="edit-save-btn">
      添削内容を保存する
    </button>

   <!--回答一覧に戻るボタン-->
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
      this.getAnswer();
      this.correctUser();
      this.checkNotGuestUser();
    },
    methods: {
      //answerのデータを受け取るメソッド
      getAnswer: function () {
        axios.get(`/users/${this.$store.state.userId}/api/answers/
        ${this.$route.params.id}/edit`)
        .then(response => {
          this.question = response.data.question
          this.answer= response.data
          this.date = response.data.date
        })
      },
      //answerの編集内容を保存するメソッド
      editAnswer: function() {
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
      correctUser: function(){
        const currentUserId = this.$store.state.userId
        if(!(currentUserId == this.$route.params.user_id)){
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
