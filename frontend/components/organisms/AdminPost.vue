<template>
  <v-container>
    <v-row
      v-for="post in posts"
      :key="post.id"
      justify="center"
    >
      <MoleculesAdminPostList
        :post="post"
        :icon-size="iconSize"
        :logged-in-user="loggedInUser"
        @destroy-post="destroyPost"
        @destroy-user="destroyUser"
      />
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
  },
  methods: {
    destroyPost () {
      this.$emit('destroy-post', this.post)
    },
    destroyUser () {
      this.$emit('destroy-user', this.post.user.id)
    },
  },
}
</script>
