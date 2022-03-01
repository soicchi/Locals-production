<template>
  <v-btn
    text
    x-large
    class="text-h6"
    :to="`/users/${userId}/following`"
    width="100%"
  >
    フォロー中
  </v-btn>
</template>

<script>
export default {
  props: {
    userId: {
      type: Number,
      required: true,
    },
  },
}
</script>
