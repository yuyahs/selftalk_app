<template>
  <div class="text-white content-center">
    <h1 class="text-center font-bold text-2xl mb-8">出題文作成</h1>
    <div class="flex flex-col text-black mx-auto max-w-md">
      <span class="text-white">出題モード選択</span>
      <select v-model="question.mode_num" class="w-16 mb-8">
        <option value=1>1</option>
        <option value=2>2</option>
      </select>
      <input type="text" v-model="question.content" class="text-2xl w-full max-w-md h-full container mx-auto bg-white shadow-md rounded-lg pl-4 pt-6 pb-8 mb-4">
      <button @click="questionNew" class="w-36 mx-auto mt-4 bg-blue-500 font-semibold text-white py-2 px-4 border border-blue-500 hover:border-transparent hover:bg-blue-300 rounded-full">
        作成する</button>
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
      questionNew: function () {
        axios.post('/api/questions', {
          question: this.question
        })
        .then(response => {
          this.$flashMessage.show({
            type: 'success',
            text:'問題を作成しました',
            time: 5000
          });
          this.question.content=""
        })
        .catch(err => {
            this.$flashMessage.show({
              type: 'error',
              text: '作成に失敗しました',
              time: 5000
            });
        })

      }
    }

  }





</script>
