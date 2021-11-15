<template>
  <header class="fixed bg-blue-900 w-full text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelfTalkEnglish</router-link>
    <div class="float-right flex flex-row text-white font-bold p-4">
      <div v-if="$store.state.loggedIn && $store.state.notGuest">
        <span class="absolute right-24 border border-solid border-white rounded-full bg-yellow-500 hover:bg-yellow-300">
          <router-link :to="{name: 'show', params: {id: $store.state.userId}}">
          マイページ</router-link>
        </span>
        <!-- ハンバーガーメニューのアイコン -->
        <div @click="showMenu" class="hamburger">
        　<!-- 1番上の線 -->
          <span class="inner_line1" id="line1">
          </span>
        　<!-- 真ん中の線 -->
          <span class="inner_line2" id="line2"></span>
        　<!-- 1番下の線 -->
          <span class="inner_line3" id="line3"></span>
        </div>
        <!-- ナビメニュー -->
        <nav id="nav">
          <ul>
            <li @click="destroySession" class="cursor-pointer hover:bg-black hover:text-white">
              ログアウト
            </li>
            <li>
              <router-link :to="{ name: 'change info', params: { id: $store.state.userId}}">
              登録情報変更</router-link></li>
            <li @click="deleteUser($store.state.userId)" class="cursor-pointer hover:bg-black hover:text-white">
              退会</li>
            <li v-if="$store.state.admin" class="mb-4 flex flex-col">
                <router-link to="/questions/new" class="mb-4 hover:bg-black cursor-pointer">問題作成
                </router-link>
                <router-link :to="{ name: 'questions', query: {mode_num: 1}}" class="mb-4 hover:bg-black cursor-pointer">問題一覧</router-link>
            </li>
          </ul>
        </nav>
      </div>
      <div v-else-if="$store.state.guest">
        <button @click="destroySession" class="mr-4 font-bold hover:bg-blue-300">
          ログアウト
        </button>
      </div>
      <div v-else>
          <router-link to="/login" class="mr-4 hover:bg-blue-300">{{nav1}}</router-link>
          <router-link to="/users/new" class="mr-4 hover:bg-blue-300 ">{{nav2}}</router-link>
      </div>
    </div>
  </header>
</template>

<script>
  import axios from 'axios';

  export default {
   name: 'Header',
    props: {
      nav1: String,
      nav2: String
    },
    created() {
      if(document.body.contains(document.getElementById('login'))) {
        const token = Math.random().toString(32).substring(2)
        this.$store.commit('login', token);
      } else {
        this.$store.commit('logout');
      }
    },
    methods: {
      destroySession: function() {
          axios.delete('/api/logout')
          .then(response => {
            this.$store.commit('logout'),
            this.$store.commit('removeId'),
            this.$store.commit('beGuest'),
            this.$store.commit('outGuest'),
            this.$router.push({ path: '/'}),
            this.$flashMessage.show({
              type: 'success',
              title: 'ログアウト',
              text:'ログアウトしました',
              time: 5000
            });
          })
          .catch(error => {
            this.$flashMessage.show({
              type: 'error',
              text: 'ログアウトできませんでした。'
            });
          })
        },
      deleteUser: function(id) {
        if(window.confirm('データが全て削除されますが退会しますか？')) {
          axios.delete('/api/users/' + id)
          .then(response => {
          this.$store.commit('guest'),
          this.$store.commit('logout'),
          this.$store.commit('removeId'),
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            text: "退会しました"
          })
          .catch(err => {
          this.$flashMessage.show({
            type: 'error',
            text: 'エラーが発生しました',
            time: 5000
          });
        })
      })
    }
  },
      showMenu: function() {
        document.getElementById('line1').classList.toggle('line_1');
        document.getElementById('line2').classList.toggle('line_2');
        document.getElementById('line3').classList.toggle('line_3');
        document.getElementById('nav').classList.toggle('in');

        }
      }
  }
</script>


