<template>
  <main>
    <Header nav1="ログイン" nav2="新規登録"/>
    <div class="flex-glow p-24">
      <router-view />
    </div>
    <Footer link1="home" link2="about" link3="contact" link4="利用規約"/>
  </main>
</template>

<script>
import Header from './components/Header'
import Footer from './components/Footer'

export default {
  name: 'App',
  components: {
    Header,
    Footer
  }
}
</script>


