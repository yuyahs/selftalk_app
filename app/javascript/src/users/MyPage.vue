<template>
  <div>
    <h1 class="user-name">
      {{user.name}}さんの学習記録
    </h1>

    <MyMenu />

    <!-- 学習記録・contributions -->
    <div class="learning-status">

      <div class="contribution">
        <p class="learning-day-p">総学習日数</p>
        <section class="learning-day">
          {{learningDays}}日
        </section>

        <p class="sequential-learning-day">連続学習日数</p>
        <section class="learning-day">
          {{$store.state.sequentialDays}}日
        </section>
      </div>

      <div class="contribution">
        <p class="this-week-p">今週の学習状況</p>
        <section v-for="day in days" :key="day" class="week-contributions-prop">
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
    <div class="answer-list-wrapper">
      <div v-for="date in dates" class="answer-list-prop" :key="date">
        <li class="answer-list-column">
          <router-link :to="{name: 'answers', query: {created_at: date}}" class="link-block">
            {{date}}の回答集
          </router-link>
        </li>
      </div>
    </div>

  </div>

</template>

<script>
  import axios from 'axios';
  import MyMenu from '../components/MyMenu';
  import Export from '../shared/exports';

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
      contributions: "",
      answerCreatedYesterday: ""

    }
  },
  mounted() {
    this.setUser();
    Export.mksureCorrectUser(this.$route.params.id);
    Export.mksureNotGuestUser();
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
        this.answerCreatedYesterday = response.data.answerCreatedYesterday //昨日移行作成されたanswerがあるかどうか確認する。なければ連続学習日数をリセットする
        if(this.answerCreatedYesterday === 0) {
          this.$store.state.sequentialDays = 0
        }
      })
    }
  }
}
</script>
