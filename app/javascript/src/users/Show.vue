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
      const id = this.$route.params.id
      axios.get(`/api/users/${this.$route.params.id}`)
      .then(response => (
        this.user = response.data,
        localStorage.setItem('Id', id),
        this.$flashMessage.show({
            type: 'success',
            text:'Welcome to SelfTalkEnglish',
            time: 5000
          })
      ))
    }
  }
}
</script>
