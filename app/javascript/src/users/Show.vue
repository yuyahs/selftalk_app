<template>
  <div>
    <div>
        <p>{{user.name}}</p>
        <p>{{user.email}}</p>
    </div>

  </div>

</template>

<script>
  import axios from 'axios';

export default {
  name: 'Show',
  data: function () {
    return {
      user: "user"
    }
  },
  mounted() {
    this.setUser();
  },
  methods: {
    setUser: function () {
      axios.get(`/api/users/${this.$route.params.id}`)
      .then(response => {
        this.user = response.data
      })
    }
  }
}
</script>
