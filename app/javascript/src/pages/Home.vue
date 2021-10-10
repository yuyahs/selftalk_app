<template>
  <div class="text-center">
   <div class="text-white pt-8">
      <h1 class="mb-8 text-4xl font-bold">SelfTalkEnglish</h1>
      <h2 class="text-2xl mb-8">”独り言英語学習”で実践力を磨く</h2>

   </div>

   <div class="inline-block">
      <button class= "my-10 bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full" >
        <router-link to="/users/new">ユーザー登録</router-link>
      </button>
      <button class= "ml-8 bg-green-500 hover:bg-green-200 hover:border-green-200 text-white font-semibold py-2 px-4 border border-green-500 rounded-full" >
        <span>ゲストログイン</span>
      </button>
   </div>



    <h1 class="text-center text-white text-3xl">学習コース一覧</h1>
    <div class ="bg-blue-300 container p-4 mt-8 mx-auto w-1/2 text-center text-black text-3xl
                    rounded-lg border-solid border-4 border-white shadow-outline">
      <h1 class = "font-bold mb-4">Self Explain</h1>
      <img class="mx-auto w-1/2 h-24" src="/assets/explain.svg">
      <p class="text-lg mt-4">質問に対して説明形式で回答</p>
      <p class="text-lg">目標回答時間：45秒</p>
      <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
        Start!<!-- <%= link_to "Start!", new_answer_path(mode_num: 1), class:"block" %> -->
      </button>
    </div>

    <div class ="bg-blue-300 container mx-auto w-1/2 my-20 py-3.5 text-center text-black text-3xl
                    rounded-lg border-solid border-4 border-white shadow-outline">
      <h2 class = "font-bold mb-4">Self Reaction</h2>
      <img class="mx-auto w-1/2 h-24" src="/assets/reaction.svg">
      <p class="text-lg mt-4">発言に対してリアクション</p>
      <p class="text-lg">目標回答時間：45秒</p>
      <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
        Start!<!-- <%= link_to "Start!", new_answer_path(mode_num: 2), class:"block" %> -->
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Home',

}
</script>
