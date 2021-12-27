<template>
  <header class="header-overall">
    <router-link to="/" class="app-title">
     SelfTalkEnglish
    </router-link>

    <div class="login-menu">
      <div v-if="$store.state.loggedIn && $store.state.notGuest">
        <button class="user-page">
          <router-link :to="{name: 'myPage', params: {id: $store.state.userId }}">
          マイページ</router-link>
        </button>

        <!-- ハンバーガーメニューのアイコン -->
        <div @click="showMenu" class="hamburger">
        　<!-- 1番上の線 -->
          <span class="inner_line1" id="line1"></span>
        　<!-- 真ん中の線 -->
          <span class="inner_line2" id="line2"></span>
        　<!-- 1番下の線 -->
          <span class="inner_line3" id="line3"></span>
        </div>

        <!-- ナビメニュー -->
        <nav id="nav">
          <ul>
            <li @click="destroySession">
              ログアウト
            </li>
            <li>
              <router-link :to="{ name: 'change info',
              params: { id: $store.state.userId }}">
               登録情報変更
              </router-link>
            </li>
            <li>
              <router-link :to="{ name: 'notices'}">お知らせ</router-link>
            </li>
            <li @click="deleteUser($store.state.userId)">
              退会
            </li>
            <li v-if="$store.state.admin">
              <router-link :to="{ name: 'adminPage' }">管理用ページ</router-link>
            </li>
          </ul>
        </nav>
      </div>

      <!-- ゲストユーザーに表示されるメニュー -->
      <div v-else-if="$store.state.guest">
        <button @click="destroySession" class="guest-menu">
          ログアウト
        </button>
      </div>

      <!-- 未ログインユーザーに表示されるメニュー -->
      <div v-else>
          <router-link to="/login" class="not-login-menu">
            ログイン
          </router-link>
          <router-link to="/users/new" class="not-login-menu">
           新規登録
          </router-link>
      </div>
    </div>
  </header>
</template>

<script>
  import axios from 'axios';
  export default {
   name: 'Header',
    mounted() {
      this.notFoundPage();
    },
    methods: {
      //logoutメソッド
      destroySession: function() {
        axios.delete('/api/logout')
        .then(response => {
          this.$store.commit('logout'),
          this.$store.commit('removeId'),
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'Logout',
            text:'ログアウトしました',
            time: 3000
          });
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: 'ログアウトできませんでした',
            time: 3000
          });
        })
      },
      //退会メソッド
      deleteUser: function(id) {
        if(window.confirm('データが全て削除されますが退会しますか？')) {
        axios.delete('/api/users/' + id)
        .then(response => {
         this.$store.commit('logout'),
         this.$store.commit('removeId'),
         this.$router.push({ path: '/'}),
         this.$flashMessage.show({
           type: 'success',
           title: '退会',
           text: '退会しました',
           time: 3000
         })
        .catch(err => {
          this.$flashMessage.show({
           type: 'error',
           text: 'エラーが発生しました',
           time: 3000
          });
        })
       })
       }
      },
      //ハンバーガーメニューメソッド
      showMenu: function() {
        document.getElementById('line1').classList.toggle('line_1');
        document.getElementById('line2').classList.toggle('line_2');
        document.getElementById('line3').classList.toggle('line_3');
        document.getElementById('nav').classList.toggle('in');
      },
      //ルーティングエラー時に専用のコンポーネントへ遷移する
      notFoundPage: function() {
        axios.get(location.pathname)
        .catch(error => {
          if(error.response.status === 404) {
            this.$router.push({name: 'Error'})
          }
        })
      }
    }
  }
</script>



