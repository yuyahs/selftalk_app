<template>
  <div class="max-w-md mx-auto">
    <button @click="addItem" class="bg-blue-500 hover:bg-blue-300 text-white font-semibold py-2 px-4">追加する+
    </button>
    <section class="flex flex-row">
      <div>
        <label for="item_content" class="text-white">単語・フレーズ</label>
        <textarea v-model="item.content" class="border border-solid border-black pl-3 pt-3 h-20 resize-none">
        </textarea>
      </div>
      <div>
        <label for="item_meaning" class="text-white">意味</label>
        <textarea v-model="item.meaning"
          class="border border-solid border-black pl-3 pt-3 h-20 resize-none">
        </textarea>
      </div>
      <div>
        <label for="item_memo" class="text-white">例文・メモ</label>
        <textarea
          v-model="item.memo"
          class="border border-solid border-black pl-3 pt-3 h-20 w-64 resize-none">
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
