<template>
  <v-btn
    text
    plain
    :to="`/users/${user.id}`"
    color="fontColor"
    :style="fontSize"
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
  computed: {
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '18px' } : { 'font-size': '20px' }
    },
  },
}
</script>
