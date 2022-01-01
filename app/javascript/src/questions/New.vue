<template>
  <div class="admin-section-wrapper">
    <h1 class="admin-title">
      出題文作成
    </h1>
    <div class="question-new-prop">
      <span class="txt-white">
        出題モード選択
      </span>

      <!-- 作成するquestionのモードを選択するプルダウン -->
      <select v-model="question.mode_num" class="mode-select">
        <option value=1>1</option>
        <option value=2>2</option>
        <option value=3>3</option>
      </select>

      <!-- question作成 -->
      <input type="text" v-model="question.content" class="new-question-text">
      <button @click="createQuestion" class="model-save-btn">
        作成する
      </button>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'QuestionNew',
    data() {
      return {
        question: {
          content: "",
          mode_num: ""
        }
      }
    },
    methods: {
      // questionを作成するメソッド
      createQuestion: function () {
        axios.post('/api/questions', {
          question: this.question
        })
        .then(response => {
          this.$flashMessage.show({
            type: 'success',
            title: '問題作成',
            text:'問題を作成しました',
            time: 3000
          });
          this.question.content=""
        })
        .catch(err => {
          this.$flashMessage.show({
            type: 'error',
            text: '作成に失敗しました',
            time: 3000
          });
        })
     　}
    }
  }
</script>
