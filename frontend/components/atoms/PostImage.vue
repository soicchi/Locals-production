<template>
  <v-dialog
    v-model="dialog"
    max-width="60%"
  >
    <template #activator="{ on, attrs }">
      <v-img
        :src="image"
        height="100%"
        width="100%"
        v-bind="attrs"
        v-on="on"
      />
    </template>
    <v-img
      :src="image"
      height="auto"
    />
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
      dialog: false
    }
  }
}
</script>
