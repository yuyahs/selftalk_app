<template>
  <div>
    <span @click="destroySession">ログアウト</span>

     <h1 class="text-center text-white text-3xl">学習コース一覧</h1>
    <div class ="bg-blue-300 container p-4 mt-8 mx-auto w-1/2 text-center text-black text-3xl
                    rounded-lg border-solid border-4 border-white shadow-outline">
      <h1 class = "font-bold mb-4">Self Explain</h1>
      <!-- <%= image_tag 'explain.svg', class:"mx-auto w-1/2 h-24" %> -->
      <p class="text-lg mt-4">質問に対して説明形式で回答</p>
      <p class="text-lg">目標回答時間：45秒</p>
      <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
        Start!<!-- <%= link_to "Start!", new_answer_path(mode_num: 1), class:"block" %> -->
      </button>
    </div>

    <div class ="bg-blue-300 container mx-auto w-1/2 my-20 py-3.5 text-center text-black text-3xl
                    rounded-lg border-solid border-4 border-white shadow-outline">
      <h2 class = "font-bold mb-4">Self Reaction</h2>
      <!-- <%= image_tag 'reaction.svg', class:"mx-auto w-1/2 h-24" %> -->
      <p class="text-lg mt-4">発言に対してリアクション</p>
      <p class="text-lg">目標回答時間：45秒</p>
      <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
        Start!<!-- <%= link_to "Start!", new_answer_path(mode_num: 2), class:"block" %> -->
      </button>
    </div>

  </div>
</template>

<script>

import axios from 'axios';

export default {
  name: 'Courses',

  methods: {
     destroySession: function() {
        axios.post('/api/logout')
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ログアウト',
            text:'ログアウトしました',
            time: 5000
          });
        })
      }


  }
}
</script>
