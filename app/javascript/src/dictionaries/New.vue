<template>
  <div class="dictionary-wrapper">
    <button @click="addItem" class="add-item-btn">追加する+
    </button>
    <section class="add-item-section">
      <div>
        <label for="item_content" class="add-item-title">単語・フレーズ</label>
        <textarea v-model="item.content" class="add-item-column">
        </textarea>
      </div>
      <div>
        <label for="item_meaning" class="add-item-title">意味</label>
        <textarea v-model="item.meaning"
          class="add-item-column">
        </textarea>
      </div>
      <div>
        <label for="item_memo" class="add-item-title">例文・メモ</label>
        <textarea
          v-model="item.memo"
          class="add-item-column">
        </textarea>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "AddItems",
  data() {
    return {
      item: {
        content: "",
        meaning: "",
        memo: "",
      },
    };
  },
  methods: {
    addItem: function () {
      axios.post("/api/items", {
        item: this.item,
      })
      .then(response => {
         this.$router.go({path: this.$router.currentRoute.path})
        })
        .catch(error => {
          this.$flashMessage.show({
            type: 'error',
            text: '入力内容に誤りがあります',
            time: 3000
          });
        })
    },
  },
};
</script>
