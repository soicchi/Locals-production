<template>
  <v-row>
    <v-col cols="12">
      <OrganismsUserInfo />
    </v-col>
    <v-col cols="12">
      <OrganismsPostFeed :posts="posts" />
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
  },
}
</script>
