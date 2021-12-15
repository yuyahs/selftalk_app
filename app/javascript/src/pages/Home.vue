<template>
  <div class="text-center">
    <!-- ログイン済み・ゲストユーザーに表示されるページ -->
    <div v-if="$store.state.loggedIn">
      <h1 class="text-white text-3xl">学習コース一覧</h1>

       <!--self explainコース -->
      <div class ="course-layout">
        <h1 class = "font-bold mb-4">Self Explain</h1>
        <img class="course-icon" src="../assets/explain.svg">
        <p class="course-text">質問に対して説明形式で回答<br>目標回答時間：45秒<br></p>
        <button class= "start-btn" >
          <router-link :to="{ name: 'courses', query: {mode_num: 1}}">
            Start!
          </router-link>
        </button>
      </div>

      <!--self reactionコース -->
      <div class ="course-layout">
        <h2 class = "font-bold mb-4">Self Reaction</h2>
        <img class="course-icon" src="../assets/reaction.svg">
        <p class="course-text">発言に対してリアクション<br>目標回答時間：45秒<br></p>
        <button class= "start-btn" >
           <router-link :to="{ name: 'courses', query: {mode_num: 2}}">
             Start!
           </router-link>
        </button>
      </div>

       <!--self translationコース -->
      <div class ="course-layout">
        <h3 class = "font-bold mb-4">Self Translation</h3>
        <img class="course-icon" src="../assets/translation.svg">
        <p class="course-text">日本語文を直感的に英訳<br>目標回答時間：45秒<br></p>
        <button class= "start-btn" >
           <router-link :to="{ name: 'courses', query: {mode_num: 3}}">
             Start!
           </router-link>
        </button>
      </div>
    </div>

    <!-- 未ログインユーザーに表示されるページ -->
    <div v-else>
      <div class="home-title-wrapper">
        <h1 class="home-title">SelfTalkEnglish</h1>
        <h2 class="home-subtitle">”独り言英語学習”で実践力を磨く</h2>
        <h3 class="home-subtitle">中級者〜上級者向け英語学習アプリ</h3>
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
          <li><img src="../assets/lp-img-2.png"></li>
          <li><img src="../assets/lp-img-3.png"></li>
          <li><img src="../assets/lp-img-4.png"></li>
        </ul>
      </div>

      <div class="home-div">
        <p class="home-subtitle">回答文は後で確認・添削可能</p>
        <img src="../assets/lp-img-1.png" class="border border-solid border-white mx-auto">
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Home',
    methods: {
      // ゲストログインメソッド
      guestLogin: function () {
        axios.post('/api/guest_sign_in')
        .then(response => {
           this.$store.commit('login')
           this.$store.commit('notGuest') //notGuestをfalseにする
           this.$store.commit('inGuest')　//inGuestをtrueにする
           this.$flashMessage.show({
            type: 'success',
            title: 'ゲストログイン',
            text:'ゲストユーザーとしてログインに成功しました',
            time: 3000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'Error',
            text: 'エラーが発生しました',
            time: 3000
          })
        });
      }
    }
  }
</script>
