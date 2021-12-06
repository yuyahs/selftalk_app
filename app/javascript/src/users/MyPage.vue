<template>
  <div>
    <h1 class="text-center text-3xl text-white font-bold pb-5">
      {{user.name}}さんの学習記録
    </h1>

    <MyMenu />

    <!-- 学習記録・contributions -->
    <div class="flex flex-row text-white my-4 p-2 max-w-md mx-auto border border-solid border-white rounded">

      <div class="contribution">
        <p class="pl-4">学習日数</p>
        <section class="learning-day">
          {{learningDays}}日
        </section>
      </div>

      <div class="contribution">
        <p class="pl-6">今週の学習状況</p>
        <section v-for="day in days" :key="day" class="flex flex-row">
          <span>
            {{day}}
          </span>
          <progress :value="contributions.filter(n => n.includes(day)).length" max="30"
          class="contribution-progress"></progress>
          <span>
            {{contributions.filter(n => n.includes(day)).length}}
          </span>
        </section>
      </div>
    </div>

    <h2 class="answer-list-title">
      自分の回答を確認する
    </h2>

    <!-- answersリンク集（日付ごとに集計） -->
    <div class="text-center p-4 flex flex-col items-center justify-center list-none">
      <div v-for="date in dates" class="w-1/2 underline p-4" :key="date">
        <li class="bg-blue-500 p-2 text-white font-bold text-2xl
                 border border-solid border-blue-500 rounded-full hover:bg-blue-300">
          <router-link :to="{name: 'answers', query: {created_at: date}}" class="block">
            {{date}}の回答集
          </router-link>
        </li>
      </div>
    </div>

  </div>

</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu'

 export default {
  name: 'mypage',
  components: {
    MyMenu
  },
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
    this.checkCorrectUser();
    this.checkNotGuestUser();
  },
  methods: {
    //user情報を取得するメソッド
    setUser: function () {
      axios.get(`/api/users/${this.$route.params.id}`)
      .then(response => {
        this.user = response.data
        this.dates = response.data.dates //answerの作成された日付の配列
        this.learningDays = response.data.learning //学習日数
        this.days = response.data.days //曜日の配列
        this.contributions = response.data.contributions //answerの作成された数の配列
      })
    },
    checkCorrectUser: function(){
      const currentUserId = this.$store.state.userId
      if(!(currentUserId == this.$route.params.id)){
        this.$router.push({name: 'home'})
      }
    },
    checkNotGuestUser: function() {
      if(this.$store.state.guest){
        this.$router.push({name: 'home'})
      }
    }
  }
}
</script>
