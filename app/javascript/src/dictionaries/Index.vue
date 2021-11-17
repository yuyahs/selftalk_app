<template>
  <div>
    <h1 class="font-bold text-2xl text-center text-white">マイ辞書</h1>
    <div>
      <AddItems />
    </div>

    <div v-for="item in items" :key="item" class="flex flex-row list-none">
      <li class="border border-solid border-black">{{item.content}}</li>
      <li class="border border-solid border-black">{{item.meaning}}</li>
      <li class="border border-solid border-black">{{item.memo}}</li>
    </div>

  </div>

</template>

<script>
  import AddItems from './New'
  import axios from 'axios';

  export default {
    name: 'Items',
    components: {
      AddItems
    },
    data() {
      return {
        items: "",
      }
    },
    mounted() {
      this.getItems();
    },
    methods: {
      getItems: function() {
        axios.get('/api/items')
        .then(response => {
          this.items = response.data
          console.log(response.data)
        })
      }
    }
  }
</script>
