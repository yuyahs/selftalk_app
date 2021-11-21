<template>
  <div class="text-center">
    <div v-if="$store.state.loggedIn">
      <h1 class="text-white text-3xl">学習コース一覧</h1>
      <div class ="course-layout">
        <h1 class = "font-bold mb-4">Self Explain</h1>
        <img class="mx-auto w-1/2 h-24" src="/assets/explain.svg">
        <p class="text-lg mt-4">質問に対して説明形式で回答</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
          <router-link :to="{ name: 'courses', query: {mode_num: 1}}">Start!</router-link>
        </button>
      </div>

      <div class ="course-layout">
        <h2 class = "font-bold mb-4">Self Reaction</h2>
        <img class="mx-auto w-1/2 h-24" src="/assets/reaction.svg">
        <p class="text-lg mt-4">発言に対してリアクション</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "mt-4 bg-yellow-500 hover:bg-white text-white font-semibold hover:text-black py-2 px-4 border border-white hover:border-yellow-500 rounded-full" >
           <router-link :to="{ name: 'courses', query: {mode_num: 2}}">Start!</router-link>
        </button>
      </div>

      <div class ="course-layout">
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
        <h2 class="home-subtitle">”独り言英語学習”で実践力を磨く</h2>
        <h3>中級者〜上級者向け英語学習アプリ</h3>
      </div>

      <div class="inline-block">
        <button class= "my-10 bg-blue-500 hover:bg-blue-300 text-white font-semibold  py-2 px-4 hover:border-transparent rounded-full">
        <router-link to="/users/new">ユーザー登録</router-link></button>

        <button @click="guestLogin" class="ml-4 bg-green-500 hover:bg-green-300 text-white font-semibold  py-2 px-4 hover:border-transparent rounded-full" >
        ゲストログイン</button>
      </div>

      <div class="home-div">
        <router-link to="/about" class="home-link-about">"独り言英語学習"とは</router-link>
      </div>

      <div class="home-div">
        <p class="home-subtitle">
          Writing形式の問題で独り言英語学習を行うためのコースを用意
        </p>
        <ul class="mx-auto max-w-md flex flex-col w-full">
          <li><img src="/assets/lp-img-2"></li>
          <li><img src="/assets/lp-img-3"></li>
          <li><img src="/assets/lp-img-4"></li>
        </ul>
      </div>

      <div class="home-div">
        <p class="home-subtitle">回答文は後で確認・添削可能</p>
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
