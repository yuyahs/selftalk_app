<template>
  <div>
    <h1 class="font-bold text-2xl text-center text-white mb-8">単語帳</h1>
    <MyMenu />
    <div>
      <AddItems />
    </div>

    <div v-for="item in items" :key="item" class="flex flex-row list-none text-lg mt-8">
      <textarea v-model="item.content" disabled class="border border-solid border-black bg-white p-4 h-20 resize-none"></textarea>


      <textarea v-model="item.meaning" disabled class="border border-solid border-black bg-white p-4 h-20 resize-none"></textarea>

      <textarea v-model="item.memo" disabled class="break-words border border-solid border-black bg-white p-4 h-20 w-96 resize-none"></textarea>


      <button @click="deleteItem(item.id)" class="text-white ml-4 underline hover:text-blue-500">
        削除
      </button>



    </div>

  </div>

</template>

<script>
  import AddItems from './New'
  import MyMenu from '../components/MyMenu.vue'
  import axios from 'axios';



  export default {
    name: 'Items',
    components: {
      AddItems,
      MyMenu
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
      },

      deleteItem: function(id) {
         if(window.confirm('本当に削除してよろしいですか？')) {
           axios.delete('/api/items/' + id)
           .then(response => {
             location.reload()
           .catch(err => {
             this.$flashMessage.show({
                 type: 'error',
                 text: '削除に失敗しました',
                 time: 5000
               });
             })
           })
         }
      }
    }
  }
</script>
