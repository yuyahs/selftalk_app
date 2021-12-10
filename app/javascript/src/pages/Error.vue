<template>
  <div class="text-white text-3xl text-center">
    <h1 class="mb-8">404 NOT FOUND</h1>
    <p class="mb-36">お探しのページは一時的にアクセスができない状況にあるか、移動もしくは削除された可能性があります。 また、URL、ファイル名にタイプミスがないか再度ご確認ください。</p>
    <router-link :to="{ name: 'home' }" class="underline hover:text-blue-500">
      HOME画面に戻る
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'Error'
}
</script>

