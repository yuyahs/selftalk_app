<template>
  <header class="bg-blue-900 text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelftalkEnglish</router-link>
    <nav class="float-right flex flex-row text-white font-bold mt-4 mr-10 ">
      <div v-if="$store.state.loggedIn">
        <span @click="destroySession" class="mr-4 hover:bg-blue-300 cursor-pointer">ログアウト
        </span>
        <router-link :to="{ name: 'change info', params: { id: UserId}}" class="mr-4 hover:bg-blue-300">登録情報を変更する</router-link>
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
    data() {


      // let userId = document.getElementById('login').textContent

      return {

        UserId: 2

      }
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
        }
    }
  }
</script>
