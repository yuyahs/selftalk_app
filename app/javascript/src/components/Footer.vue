<template>
  <footer class="bg-blue-900 text-center text-white border-t-2 border-fuchsia-600">
  <div class="p-16">
   <ul>
      <li class="space-x-10 border-b-2 border-fuchsia-600">
        <span>{{link1}}</span>
        <span>{{link2}}</span>
        <span>{{link3}}</span>
        <span>{{link4}}</span>
      </li>
   </ul>
  </div>
</footer>
</template>

<script>
export default {
  name: 'Footer',
  props: {
    link1: String,
    link2: String,
    link3: String,
    link4: String,
  }
}
</script>
