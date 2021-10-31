<template>
  <div>
    <h1 class="text-center text-3xl text-white font-bold pb-5">{{user.name}}さんの学習記録</h1>

    <!-- 学習記録・contributions -->
    <div class="absolute inset-y-36 left-24 text-white">
      <p class="ml-4">学習日数</p>
      <section class="w-24 h-24 pt-8 mb-4 text-center object-cover border border-solid border-white rounded-full">
      {{learningDays}}日</section>

      <p>今週の学習状況</p>
      <section v-for="day in days" :key="day" class="flex flex-row">
        <span>{{day}}</span>
        <progress :value="contributions.filter(n => n === day).length" max="30" class="absolute w-32 ml-10 mt-1 border border-solid border-white h-4"></progress>
         <span class="absolute right-0">{{contributions.filter(n => n === day).length}}</span>
      </section>
    </div>

    <!-- answersリンク集（日付ごとに集計） -->
    <div class="text-center flex flex-col items-center justify-center">
      <div v-for="date in dates" class="mt-8" :key="date">
        <router-link :to="{name: 'answers', query: {created_at: date}}"
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
      dates: "",
      learningDays: "",
      days: "",
      contributions: ""
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
        this.learningDays = response.data.learning
        this.days = response.data.days
        this.dates = response.data.dates
        this.contributions = response.data.contributions
      })
    }
  }
}
</script>
