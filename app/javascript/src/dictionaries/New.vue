<template>
  <div class="max-w-md mx-auto">
    <section class="flex flex-row mt-12">
      <div>
        <label for="item_content" class="text-white">単語・フレーズ</label>
        <input
          v-model="item.content"
          class="border border-solid border-black pl-3 h-20"
        />
      </div>
      <div>
        <label for="item_meaning" class="text-white">意味</label>
        <textarea v-model="item.meaning"
          class="border border-solid border-black pl-3 pt-3 h-20 resize-none">
        </textarea>
      </div>
      <div>
        <label for="item_memo" class="text-white">例文</label>
        <textarea
          v-model="item.memo"
          class="border border-solid border-black pl-3 pt-3 h-20 w-64 resize-none">
        </textarea>
      </div>
    </section>
    <button @click="addItem" class="bg-blue-500 hover:bg-blue-300 text-white font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded-full">登録する
    </button>
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
            text: '入力内容に誤りがあります。'
          });
        })
    },
  },
};
</script>
