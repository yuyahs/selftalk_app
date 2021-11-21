<template>
  <div class="text-center">
    <div v-if="$store.state.loggedIn">
      <h1 class="text-center text-white text-3xl">学習コース一覧</h1>
      <div class ="bg-blue-300 p-4 mt-8 mx-auto md:w-1/2 text-center text-black text-3xl
                      rounded-lg border-solid border-4 border-white shadow-outline">
        <h1 class = "font-bold mb-4">Self Explain</h1>
        <img class="mx-auto w-1/2 h-24" src="/assets/explain.svg">
        <p class="text-lg mt-4">質問に対して説明形式で回答</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
          <router-link :to="{ name: 'courses', query: {mode_num: 1}}">Start!</router-link>
        </button>
      </div>

      <div class ="bg-blue-300 container mx-auto md:w-1/2 my-20 py-3.5 text-center text-black text-3xl
                      rounded-lg border-solid border-4 border-white shadow-outline">
        <h2 class = "font-bold mb-4">Self Reaction</h2>
        <img class="mx-auto w-1/2 h-24" src="/assets/reaction.svg">
        <p class="text-lg mt-4">発言に対してリアクション</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
           <router-link :to="{ name: 'courses', query: {mode_num: 2}}">Start!</router-link>
        </button>
      </div>

      <div class ="bg-blue-300 container mx-auto md:w-1/2 my-20 py-3.5 text-center text-black text-3xl
                      rounded-lg border-solid border-4 border-white shadow-outline">
        <h3 class = "font-bold mb-4">Self Translation</h3>
        <img class="mx-auto w-1/2 h-24" src="/assets/translation.svg">
        <p class="text-lg mt-4">日本語文を直感的に英訳</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
           <router-link :to="{ name: 'courses', query: {mode_num: 3}}">Start!</router-link>
        </button>
      </div>
    </div>


    <div v-else>
      <div class="text-white pt-8">
        <h1 class="mb-8 text-4xl font-bold">SelfTalkEnglish</h1>
        <h2 class="md:text-2xl mb-8">”独り言英語学習”で実践力を磨く</h2>
        <h3>中級者〜上級者向け英語学習アプリ</h3>
      </div>

      <div class="inline-block">
        <button class= "my-10 bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-solid hover:border-transparent rounded-full">
        <router-link to="/users/new">ユーザー登録</router-link></button>

        <button @click="guestLogin" class= "md:ml-8 bg-green-500 hover:bg-green-200 hover:border-green-200 text-white font-semibold py-2 px-4 border border-solid rounded-full" >
        ゲストログイン</button>
      </div>

      <div class="home-div">
        <router-link to="/about" class="md:text-2xl md:w-1/3 max-w-md mx-auto border border-solid border-white rounded-lg bg-blue-500 bg-opacity-75 p-2 hover:bg-blue-300 block">"独り言英語学習"とは</router-link>
      </div>

      <div class="home-div">
        <p class="md:text-2xl mb-4">
          Writing形式の問題で独り言英語学習を行うためのコースを用意
        </p>
        <ul class="mx-auto max-w-md flex flex-col w-full">
          <li><img src="/assets/lp-img-2"></li>
          <li><img src="/assets/lp-img-3"></li>
          <li><img src="/assets/lp-img-4"></li>
        </ul>
      </div>

      <div class="home-div">
        <p class="md:text-2xl">回答文は後で確認・添削可能</p>
        <img src="/assets/lp-img-1" class="border border-solid border-white mx-auto">
      </div>

    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  const token = Math.random().toString(32).substring(2)
  export default {
    name: 'Home',
    methods: {
      guestLogin: function () {
        axios.post('/api/guest_sign_in')
        .then(response => {
           this.$store.commit('login', token)
           this.$store.commit('notGuest')
           this.$store.commit('inGuest')
           this.$flashMessage.show({
            type: 'success',
            title: 'ゲストログイン',
            text:'ゲストユーザーとしてログインに成功しました。',
            time: 5000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: 'エラーが発生しました'
          })
        });

      }
    }




  }
</script>
