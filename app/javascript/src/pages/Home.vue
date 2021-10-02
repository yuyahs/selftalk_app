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

  </div>
</template>

<script>
export default {
  name: 'Home',

}
</script>
