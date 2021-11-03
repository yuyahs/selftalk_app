<template>
  <main>
    <Header nav1="ログイン" nav2="新規登録"/>
    <div class="flex-grow p-24 ">
      <FlashMessage position="left top" />
      <router-view />
    </div>
    <Footer/>
  </main>
</template>

<script>
  import Header from './components/Header'
  import Footer from './components/Footer'





  export default {
    name: 'App',
    components: {
      Header,
      Footer,
    },




  }
</script>


