<template>
  <v-sheet
    height="100px"
    class="pa-2"  
  >
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
