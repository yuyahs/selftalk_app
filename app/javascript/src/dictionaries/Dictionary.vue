<template>
  <div>
    <h1 class="content-title">
      単語帳
    </h1>

    <MyMenu />

    <!-- 新規追加欄 -->
    <div>
      <AddItems />
    </div>

    <!-- 保存した単語・フレーズ一覧表示 -->
    <div v-for="item in items" :key="item" class="items">
      <textarea v-model="item.content" disabled class="items-colum"></textarea>

      <textarea v-model="item.meaning" disabled class="items-colum"></textarea>

      <textarea v-model="item.memo" disabled class="items-memo"></textarea>

      <button @click="deleteItem(item.id)" class="items-delete">
        削除
      </button>

      <input type="checkbox" class="checkbox">
    </div>
  </div>

</template>

<script>
  import AddItems from './New'
  import MyMenu from '../components/MyMenu.vue'
  import axios from 'axios';

  export default {
    name: 'Dictionary',
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
      this.checkCorrectUser();
      this.checkNotGuestUser();
    },
    //保存したフレーズ集を取得するメソッド
    methods: {
      getItems: function() {
        axios.get(`/users/${this.$route.params.id}/api/items`)
        .then(response => {
          this.items = response.data.items
        })
      },
      //保存したフレーズを削除するメソッド
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
      },
      checkCorrectUser: function () {
        const currentUserId = localStorage.getItem('userId')
        if(!(currentUserId == this.$route.params.id)){
          this.$router.push({name: 'home'})
        }
      },
      checkNotGuestUser: function() {
        if(this.$store.state.guest){
          this.$router.push({name: 'home'})
        }
      }
    }
  }
</script>
