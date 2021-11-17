<template>
  <div class="items-center justify-center">
    <h1>マイ辞書</h1>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'AddItems',
    data() {
      return {
        answers: "",
      }
    },
  }
</script>
