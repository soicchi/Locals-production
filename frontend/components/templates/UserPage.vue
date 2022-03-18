<template>
  <v-row>
    <v-col cols="12">
      <OrganismsUserInfo />
    </v-col>
    <v-col cols="12">
      <OrganismsPostFeed
        :posts="posts"
        :logged-in-user="loggedInUser"
        :icon-size="iconSize"
        :post-card-width="postCardWidth"
        @destroy-post="destroyPost"
      />
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    postCardWidth: {
      type: String,
      required: true,
    },
  },
  methods: {
    destroyPost (post) {
      this.$emit('destroy-post', post)
    },
  },
}
</script>
