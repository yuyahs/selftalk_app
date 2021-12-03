<template>
  <div class="my-menu">
    <ul>
      <li>
        <router-link :to="{name: 'show', params: {id: $store.state.userId }}" class="mypage-link">
          マイページ
        </router-link>
        <router-link to="/" class="course-link">
         コース一覧
        </router-link>
      </li>
      <li>
        <router-link to="/dictionaries" class="dictionary-link">
          単語帳
        </router-link>
      </li>
    </ul>
  </div>

</template>

<script>
  export default {
    name: "MyMenu"
  }
</script>
