<template>
  <footer class="bg-blue-900 text-center text-white border-t-2 border-fuchsia-600">
    <div class="p-16">
      <ul class="space-x-10 border-b-2 border-fuchsia-600 flex flex-row items-center justify-center">
          <li><router-link to="/">home</router-link></li>
          <li><router-link to="/about">about</router-link></li>
          <li><router-link to="/contacts/new">conatct</router-link></li>
          <li><router-link to="/policy">利用規約</router-link></li>
      </ul>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>
