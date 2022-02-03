<template>
  <div class="home-wrapper">
    <!-- ログイン・ゲストユーザーに表示されるページ -->
    <div v-if="$store.state.loggedIn">
      <h1 class="home-title">学習コース一覧</h1>

       <!--self explainコース -->
      <div class ="course-layout">
        <h1 class = "course-title">Self Explain</h1>
        <img class="course-icon" src="../assets/explain.svg">
        <p class="course-text">質問に対して説明形式で回答<br>目標回答時間：60秒<br></p>
        <button class= "start-btn" >
          <router-link :to="{ name: 'courses', query: {mode_num: 1}}">
            Start!
          </router-link>
        </button>
      </div>

      <!--self reactionコース -->
      <div class ="course-layout">
        <h2 class = "course-title">Self Reaction</h2>
        <img class="course-icon" src="../assets/reaction.svg">
        <p class="course-text">発言に対してリアクション<br>目標回答時間：60秒<br></p>
        <button class= "start-btn" >
           <router-link :to="{ name: 'courses', query: {mode_num: 2}}">
             Start!
           </router-link>
        </button>
      </div>

       <!--self translationコース -->
      <div class ="course-layout">
        <h3 class = "course-title">Self Translation</h3>
        <img class="course-icon" src="../assets/translation.svg">
        <p class="course-text">日本語文を直感的に英訳<br>目標回答時間：60秒<br></p>
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
        <h1 class="lp-title">SelfTalkEnglish</h1>
        <h2 class="home-subtitle">「テストの点数は取れるけど話せない、、」
        </h2>
        <h3 class="home-subtitle">から脱する”独り言英語学習”実践アプリ</h3>
      </div>

      <div class="inline-block">
        <button class= "signin-link">
        <router-link to="/users/new">ユーザー登録</router-link></button>
        <button @click="loginAsGuest" class="guest-link" >
        ゲストログイン</button>
      </div>


      <div class="home-div">
        <router-link to="/about" class="home-link-about">"独り言英語学習"とは</router-link>
      </div>

      <div class="home-div">
        <p class="home-subtitle">
          Writing形式の問題で独り言英語学習を行うためのコースを用意
        </p>
        <p class="home-subtitle">
          アウトプットに対する抵抗感を緩和します
        </p>
        <ul class="course-images">
          <li><img src="../assets/course-image1.png"></li>
          <li><img src="../assets/course-image2.png"></li>
          <li><img src="../assets/course-image3.png"></li>
        </ul>
      </div>

      <div class="home-div">
        <p class="home-subtitle">回答文は後で確認・添削可能</p>
        <img src="../assets/lp-img-1.png" class="edit-image">
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
      loginAsGuest: function () {
           this.$store.commit('login')
           this.$store.commit('notGuest') //notGuestをfalseにする
           this.$store.commit('inGuest')　//inGuestをtrueにする
           this.$flashMessage.show({
            type: 'success',
            title: 'ゲストログイン',
            text:'ゲストユーザーとしてログインに成功しました',
            time: 3000
          });
      }
    }
  }
</script>
