<template>
  <v-chip
    close
    @click:close="removeCategory"
  >
    {{ category.name }}
  </v-chip>
</template>

<script>
export default {
  props: {
    category: {
      type: Object,
      required: true,
    },
  },
  methods: {
    removeCategory () {
      this.$emit('remove-category', this.category.id)
    }
  }
}
</script>