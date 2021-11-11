<template>
  <header class="fixed bg-blue-900 w-full text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelfTalkEnglish</router-link>
    <div class="float-right flex flex-row text-white font-bold mt-4 mr-10">
      <div v-if="$store.state.loggedIn && $store.state.notGuest">
        <router-link :to="{name: 'show', params: {id: $store.state.userId}}"
        class="p-2 mr-16 border border-solid border-white rounded-full bg-yellow-500 hover:bg-yellow-300">
          マイページ</router-link>
        <!-- ハンバーガーメニューのアイコン -->
        <div @click="showMenu" class="absolute block top-5 right-7 w-12 cursor-pointer z-10">
        　<!-- 1番上の線 -->
          <span class="absolute border border-white left-0 top-0 w-10 h-0.5 transform" id="line1">
          </span>
        　<!-- 真ん中の線 -->
          <span class="absolute border border-white left-0 top-2.5 w-10 h-0.5" id="line2"></span>
        　<!-- 1番下の線 -->
          <span class="absolute border border-white left-0 top-0 w-10 h-0.5 transform" id="line3"></span>
          <span class="absolute border border-white left-0 top-5 w-10 h-0.5 transform" id="line4"></span>
        </div>
        <!-- ナビメニュー -->
        <nav id="nav" class="bg-blue-700 absolute top-0 w-2/5 h-screen hidden">
          <ul class="pt-20 pl-4 pr-80 text-white text-center">
            <li @click="destroySession" class="mb-4 hover:bg-black cursor-pointer">
              ログアウト
            </li>
            <li class="mb-4 hover:bg-black">
              <router-link :to="{ name: 'change info', params: { id: $store.state.userId}}">
              登録情報変更</router-link></li>
            <li @click="deleteUser($store.state.userId)" class="mb-4 hover:bg-black cursor-pointer">退会</li>
            <li v-if="$store.state.admin" class="mb-4 flex flex-col">
                <router-link to="/questions/new" class="mb-4 hover:bg-black">問題作成
                </router-link>
                <router-link :to="{ name: 'questions', query: {mode_num: 1}}" class="hover:bg-black">問題一覧</router-link>
            </li>
          </ul>
        </nav>
      </div>
      <div v-else-if="$store.state.guest">
        <button @click="destroySession" class="mr-4 hover:bg-blue-300">ログアウト

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
        document.getElementById('nav').classList.toggle('hidden');
        document.getElementById('line1').classList.toggle('rotate-45');
        document.getElementById('line2').classList.toggle('opacity-0');
        document.getElementById('line3').classList.toggle('-rotate-45');
        document.getElementById('line4').classList.toggle('hidden');

        }
      }
  }
</script>


