<template>
  <v-sheet height="100px">
    {{ post.comment }}
  </v-sheet>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
  },
}
</script>
