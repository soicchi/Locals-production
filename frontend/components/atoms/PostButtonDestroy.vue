<template>
  <v-btn
    icon
    large
    @click="destroyPost"
  >
    <v-icon>
      mdi-trash-can-outline
    </v-icon>
  </v-btn>
</template>

<script>
export default {
  methods: {
    destroyPost () {
      this.$emit('destroy-post')
    },
  },
}
</script>
