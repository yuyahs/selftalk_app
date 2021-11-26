<template>
  <div class="text-white content-center border border-solid border-white">
    <h1 class="admin-title">
      出題文作成
    </h1>
    <div class="flex flex-col mx-auto max-w-md">
      <span class="text-white">
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
      <button @click="questionNew" class="w-36 mx-auto my-4 bg-blue-500 font-semibold text-white py-2 px-4 border border-blue-500 hover:border-transparent hover:bg-blue-300 rounded-full">
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
      questionNew: function () {
        axios.post('/api/questions', {
          question: this.question
        })
        .then(response => {
          this.$flashMessage.show({
            type: 'success',
            text:'問題を作成しました',
            time: 1000
          });
          this.question.content=""
        })
        .catch(err => {
          this.$flashMessage.show({
            type: 'error',
            text: '作成に失敗しました',
            time: 1000
          });
        })
     　}
    }
  }
</script>
