<template>
  <div>
    <Header nav1="ログイン" nav2="新規登録"/>

    <Footer link1="home" link2="about" link3="contact" link4="利用規約"/>
  </div>
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


