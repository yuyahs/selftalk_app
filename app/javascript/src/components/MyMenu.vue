<template>

  <div class="my-menu">
    <ul>
      <li>
        <router-link to="/" class="course-link">コース一覧</router-link>
      </li>
      <li><router-link to="/items" class="dictionary-link">MyDictionary</router-link></li>
    </ul>
  </div>

</template>

<script>
  export default {
    name: "MyMenu"
  }
</script>
