<template>
  <v-sheet
    color="baseColor"
    :style="fontSize"
  >
    {{ introduction }}
  </v-sheet>
</template>

<script>
export default {
  props: {
    introduction: {
      type: String,
      required: true,
    },
  },
  computed: {
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '12px' } : { 'font-size': '16px' }
    },
  },
}
</script>
