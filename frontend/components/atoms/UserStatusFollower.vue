<template>
  <!-- フォロワー一覧へのリンク実装予定 -->
  <v-btn
    text
    plain
    :to="`/users/${userId}/followers`"
    class="pl-0"
  >
    Followers : {{ followersCount }}
  </v-btn>
</template>

<script>
export default {
  props: {
    followersCount: {
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
