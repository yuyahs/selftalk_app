<template>
  <div class="text-center">
    <!-- ログイン済み・ゲストユーザーに表示されるページ -->
    <div v-if="$store.state.loggedIn">
      <h1 class="text-white text-3xl">学習コース一覧</h1>
      <div class ="course-layout">
        <h1 class = "font-bold mb-4">Self Explain</h1>
        <img class="mx-auto w-1/2 h-24" src="/assets/explain.svg">
        <p class="text-lg mt-4">質問に対して説明形式で回答</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "start-btn" >
          <router-link :to="{ name: 'courses', query: {mode_num: 1}}">Start!</router-link>
        </button>
      </div>

      <div class ="course-layout">
        <h2 class = "font-bold mb-4">Self Reaction</h2>
        <img class="mx-auto w-1/2 h-24" src="/assets/reaction.svg">
        <p class="text-lg mt-4">発言に対してリアクション</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "start-btn" >
           <router-link :to="{ name: 'courses', query: {mode_num: 2}}">Start!</router-link>
        </button>
      </div>

      <div class ="course-layout">
        <h3 class = "font-bold mb-4">Self Translation</h3>
        <img class="mx-auto w-1/2 h-24" src="/assets/translation.svg">
        <p class="text-lg mt-4">日本語文を直感的に英訳</p>
        <p class="text-lg">目標回答時間：45秒</p>
        <button class= "start-btn" >
           <router-link :to="{ name: 'courses', query: {mode_num: 3}}">Start!</router-link>
        </button>
      </div>
    </div>

    <!-- 未ログインユーザーに表示されるページ -->
    <div v-else>
      <div class="home-title-wrapper">
        <h1 class="home-title">SelfTalkEnglish</h1>
        <h2 class="home-subtitle">”独り言英語学習”で実践力を磨く</h2>
        <h3>中級者〜上級者向け英語学習アプリ</h3>
      </div>

      <div class="inline-block">
        <button class= "signin-link">
        <router-link to="/users/new">ユーザー登録</router-link></button>

        <button @click="guestLogin" class="guest-link" >
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
      // ゲストログインメソッド
      guestLogin: function () {
        axios.post('/api/guest_sign_in')
        .then(response => {
           this.$store.commit('login', token)
           this.$store.commit('notGuest') //notGuestをfalseにする
           this.$store.commit('inGuest')　//inGuestをtrueにする
           this.$flashMessage.show({
            type: 'success',
            title: 'ゲストログイン',
            text:'ゲストユーザーとしてログインに成功しました。',
            time: 1000
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
