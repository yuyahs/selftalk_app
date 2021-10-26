<template>
  <div>
    <h1 class="text-center text-3xl text-white font-bold pb-5">{{user.name}}さんの学習記録</h1>
    <div class="text-center flex items-center justify-center">
      <div v-for="date in dates" class="mt-4" :key="date">
        <router-link :to="{name: 'answers', params: {created_at: date}}"
        class="p-2 bg-white list-none underline text-black mt-5 font-bold text-2xl
                 border border-solid border-white rounded-full hover:bg-black hover:text-white">
         {{date}}
        </router-link>
      </div>

    </div>

  </div>

</template>

<script>
  import axios from 'axios';

export default {
  name: 'Show',
  data: function () {
    return {
      user: "",
      dates: ""
    }
  },
  mounted() {
    this.setUser();
  },
  methods: {
    setUser: function () {
      axios.get(`/api/users/${this.$route.params.id}`)
      .then(response => {
        this.user = response.data
        this.dates = response.data.dates
      })
    }
  }
}
</script>
