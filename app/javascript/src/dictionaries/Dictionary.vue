<template>
  <div>
    <h1 class="content-title">
      My単語帳
    </h1>

    <MyMenu />

    <div>
      <AddItems />
    </div>

    <section class="items">
      <div>
        <li v-for="item in items" :key="item" class="items-column">
          {{item.content}}
         </li>
      </div>
      <div>
        <li v-for="item in items" :key="item" class="items-column">
          {{item.meaning}}
        </li>
      </div>
      <div>
        <li v-for="item in items" :key="item" class="items-memo">
          {{item.memo}}
          <button @click="deleteItem(item.id)" class="items-delete">
            削除
          </button>
        </li>
      </div>
    </section>
  </div>

</template>

<script>
  import AddItems from './New'
  import MyMenu from '../components/MyMenu.vue'
  import axios from 'axios';
  import Export from '../shared/exports';

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
      this.getAllItems();
      Export.mksureCorrectUser(this.$route.params.id);
      Export.mksureNotGuestUser();
    },
    //保存したフレーズ集を取得するメソッド
    methods: {
      getAllItems: function() {
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
      }
    }
  }
</script>
