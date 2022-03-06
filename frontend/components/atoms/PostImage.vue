<template>
  <v-dialog
    v-model="dialog"
    :max-width="dialogWidth"
  >
    <template #activator="{ on, attrs }">
      <picture>
        <source
          :srcSet="`${image}?webp`"
          type="image/webp"
          height="100%"
          width="100%"
          v-bind="attrs"
          :style="{ 'cursor': 'pointer' }"
          v-on="on"
        >
        <img
          :src="image"
          height="100%"
          width="100%"
          v-bind="attrs"
          :style="{ 'cursor': 'pointer' }"
          v-on="on"
        >
      </picture>
    </template>
      <img
        :src="image"
        height="auto"
      >
  </v-dialog>
</template>

<script>
export default {
  props: {
    image: {
      type: String,
      required: true,
    },
  },
  data () {
    return {
      dialog: false,
    }
  },
  computed: {
    dialogWidth () {
      return this.$vuetify.breakpoint.xs ? '80%' : '60%'
    },
  },
}
</script>
