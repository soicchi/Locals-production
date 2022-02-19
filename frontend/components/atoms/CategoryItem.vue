<template>
  <div>
    <v-chip
      v-for="category in categories"
      :key="category.id"
      label
      outlined
      color="subColor"
      class="mr-3"
    >
      {{ category.name }}
    </v-chip>
  </div>
</template>

<script>
export default {
  props: {
    categories: {
      type: Array,
      required: true,
    },
  },
}
</script>
