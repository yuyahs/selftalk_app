<template>
  <main>
    <Header nav1="ログイン" nav2="新規登録"/>
    <div class="contents">
      <FlashMessage position="left top"/>
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
    mounted : function(){
      const routeInstance = this.$route;
      this.createTitleDesc(routeInstance);
    },
    methods: {
      // タイトルを設定
      createTitleDesc : function(routeInstance){
        if(routeInstance.meta.title){
          const setTitle = routeInstance.meta.title + ' | SelfTalkEnglish';
          document.title = setTitle;
        } else {
          document.title = 'SelfTalkEnglish'
        }
      }
    },
    watch: {
      '$route' (routeInstance, from) {
       this.createTitleDesc(routeInstance);
      }
    }
  }
</script>


