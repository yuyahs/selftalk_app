<template>
  <div>
    <h1 class="text-center text-3xl text-white font-bold pb-5">{{user.name}}さんの学習記録</h1>

    <!-- 学習記録・contributions -->
    <div class="flex flex-row text-white my-4 p-2 max-w-md mx-auto border border-solid border-white rounded">
      <div class="contribution">
        <p class="pl-4">学習日数</p>
        <section class="w-24 h-24 pt-8 text-center object-cover border border-solid border-white rounded-full">
        {{learningDays}}日</section>
      </div>
      <div class="contribution">
        <p class="pl-6">今週の学習状況</p>
        <section v-for="day in days" :key="day" class="flex flex-row">
          <span>{{day}}</span>
          <progress :value="contributions.filter(n => n.includes(day)).length" max="30"
          class="w-32 mt-1 border border-solid border-white h-4"></progress>
          <span>{{contributions.filter(n => n.includes(day)).length}}
          </span>
        </section>
      </div>
    </div>

    <h2 class="text-center text-3xl text-white font-bold mb-8">
      自分の回答を確認する
    </h2>
    <!-- answersリンク集（日付ごとに集計） -->
    <div class="text-center p-4 flex flex-col items-center justify-center list-none border border-solid rounded ">
      <div v-for="date in dates" class="w-1/2 underline p-4" :key="date">
        <li class="bg-white p-2 text-black font-bold text-2xl
                 border border-solid border-blue-500 rounded-full hover:bg-black hover:text-white"><router-link :to="{name: 'answers', query: {created_at: date}}" class="block">
         {{date}}の回答集
        </router-link></li>
      </div>
    </div>

    <div class="text-center">
      <button class="underline bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white p-4 border border-solid border-white"><router-link to="/" class="block">
        コース一覧へ</router-link>
      </button>
      <button class="underline bg-green-500 hover:bg-green-300 text-white font-semibold hover:text-white p-4 border border-solid border-white">
        <router-link to="/items" class="block">
        My辞書へ</router-link>
      </button>
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
