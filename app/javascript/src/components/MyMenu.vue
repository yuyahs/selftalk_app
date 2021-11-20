<template>

  <div class="w-1/6 text-2xl text-white text-center">
    <ul>
      <li>
        <router-link to="/" class="bg-blue-500 border border-solid border-white block hover:bg-blue-300">コース一覧</router-link>
      </li>
      <li><router-link to="/items" class="bg-green-500 border border-solid border-white block hover:bg-green-300">MyDictionary</router-link></li>
    </ul>
  </div>

</template>

<script>
  export default {
    name: "MyMenu"
  }
</script>
