<template>
  <div>
   <h1>{{ title }}</h1>
   <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    title: String,
    message: String,
  }
}
</script>

<style scoped>
</style>