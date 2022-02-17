<template>
  <v-btn
    text
    plain
    :to="`/users/${user.id}`"
    color="fontColor"
    class="user-name"
  >
    {{ user.name }}
  </v-btn>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style lang="sass" scoped>
  .user-name
    font-size: 20px
</style>
