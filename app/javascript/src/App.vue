<template>
  <HelloJSX />
</template>

<script>
import HelloJSX from './components/helloJSX.jsx'

export default {
  name: 'App',
  components: {
    HelloJSX
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>