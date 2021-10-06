<template>
  <header class="bg-blue-900 text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelftalkEnglish</router-link>
    <nav class="float-right flex flex-row text-white font-bold mt-4 mr-10 ">
      <div class="flex flex-row ">
        <router-link to="/login" class="mr-4 hover:bg-blue-300">{{nav1}}</router-link>
        <router-link to="/users/new" class="mr-4 hover:bg-blue-300 ">{{nav2}}
        </router-link>

      </div>

    </nav>
  </header>
</template>

<script>



export default {
  name: 'Header',
  props: {
    nav1: String,
    nav2: String
  },
  methods: {
     destroySession: function() {
        axios.post('/api/logout')
        .then(response => {
          this.$router.push({ path: '/'}),
          this.$flashMessage.show({
            type: 'success',
            title: 'ログアウト',
            text:'ログアウトしました',
            time: 5000
          });
        })
      }
  }
}
</script>
