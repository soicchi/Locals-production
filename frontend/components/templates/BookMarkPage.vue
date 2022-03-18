<template>
  <div>
    <v-col
      cols="12"
      class="py-7"
    >
      <AtomsCommonTitle :title="title" />
    </v-col>
    <OrganismsPostFeed
      :icon-size="iconSize"
      :posts="bookMarkPosts"
      :logged-in-user="loggedInUser"
      :post-card-width="postCardWidth"
    />
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    bookMarkPosts: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    postCardWidth: {
      type: String,
      required: true,
    },
  },
}
</script>
