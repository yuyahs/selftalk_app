<template>
  <div class="items-center justify-center">
    <h1>マイ辞書</h1>
  </div>

</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Items',
    data() {
      return {
        answers: "",
      }
    }
  }
</script>
