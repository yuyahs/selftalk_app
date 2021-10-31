<template>
  <header class="bg-blue-900 text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelfTalkEnglish</router-link>
    <nav class="float-right flex flex-row text-white font-bold mt-4 mr-10">
      <div v-if="$store.state.loggedIn" class="float-right flex flex-row">
        <router-link :to="{name: 'show', params: {id: $store.state.userId}}" class="mr-4 hover:bg-blue-300">マイページ</router-link>
        <ul>
          <li id="menu" @click="showMenu" class="hover:bg-blue-300 cursor-pointer">メニュー▼</li>
          <div id="tab" class="absolute right-4 p-2 w-1/6 bg-blue-900 font-thin border border-solid border-white rounded hidden">
            <li @click="destroySession" class="mr-4 hover:bg-blue-300 cursor-pointer">ログアウト
            </li>
            <router-link :to="{ name: 'change info', params: { id: $store.state.userId}}" class="mr-4 hover:bg-blue-300">登録情報を変更する</router-link>
            <li v-if="$store.state.admin" class="flex flex-col">
              <router-link to="/questions/new" class="mr-4 hover:bg-blue-300" >
              問題作成</router-link>
              <router-link to="/questions" class="mr-4 hover:bg-blue-300">問題一覧</router-link>
            </li>
          </div>
        </ul>
      </div>
      <div v-else>
        <router-link to="/login" class="mr-4 hover:bg-blue-300">{{nav1}}</router-link>
        <router-link to="/users/new" class="mr-4 hover:bg-blue-300 ">{{nav2}}</router-link>
      </div>

    </nav>
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
      showMenu: function() {
        const tab = document.getElementById('tab')
        const menu = document.getElementById('menu')
        document.addEventListener("click", (e) => {
        if(e.target.closest("#menu")) {
          tab.classList.contains("hidden") ? tab.classList.remove("hidden") : tab.classList.add("hidden");
        }else {
          tab.classList.add("hidden");
        }
        });
      },
    }
  }
</script>
