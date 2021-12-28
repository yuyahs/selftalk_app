<template>
  <footer class="footer-overall">
    <div class="footer-div">
      <ul class="footer-links">
          <li class="footer-link"><router-link to="/">home</router-link></li>
          <li class="footer-link"><router-link to="/about">about</router-link></li>
          <li class="footer-link"><router-link to="/contacts">conatct</router-link></li>
          <li class="footer-link"><router-link to="/policy">policy</router-link></li>
      </ul>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>
