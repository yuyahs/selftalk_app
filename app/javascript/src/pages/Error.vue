<template>
  <div class="error-wrapper">
    <h1 class="error-title">404 NOT FOUND</h1>
    <p class="error-sentence">お探しのページは一時的にアクセスができない状況にあるか、移動もしくは削除された可能性があります。また、URL,ファイル名にタイプミスがないか再度ご確認ください。</p>
    <router-link :to="{ name: 'home' }" class="error-home-link">
      HOME画面に戻る
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'Error'
}
</script>

