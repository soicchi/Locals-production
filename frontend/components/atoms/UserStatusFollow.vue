<template>
  <v-btn
    text
    plain
    :to="`/users/${userId}/following`"
  >
    Follow : {{ followingCount }}
  </v-btn>
</template>

<script>
export default {
  props: {
    followingCount: {
      type: Number,
      required: true,
      default: 0,
    },
    userId: {
      type: Number,
      required: true,
    },
  },
}
</script>
