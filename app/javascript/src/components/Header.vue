<template>
  <header class="bg-blue-900 text-white h-16 border-b-2 border-fuchsia-600">
    <router-link to="/" class="font-serif text-3xl ">SelftalkEnglish</router-link>
    <nav class="float-right flex flex-row text-white font-bold mt-4 mr-10 ">
      <ul class="flex flex-row ">
        <li class="mr-4 hover:bg-blue-300 ">{{nav1}}</li>
        <li class="mr-4 hover:bg-blue-300">{{nav2}}</li>
      </ul>

    </nav>
  </header>
</template>

<script>
export default {
  name: 'Header',
  props: {
    nav1: String,
    nav2: String
  }
}
</script>
