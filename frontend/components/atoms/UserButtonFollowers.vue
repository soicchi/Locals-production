<template>
  <v-btn
    text
    x-large
    class="text-h6"
    :to="`/users/${userId}/followers`"
    width="100%"
  >
    フォロワー
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
