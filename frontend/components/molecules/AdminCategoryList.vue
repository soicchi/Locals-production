<template>
  <v-row>
    <v-col>
      <v-chip
        v-for="category in categories"
        :key="category.id"
        class="mr-2 mb-2"
      >
        {{ category.name }}
      </v-chip>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    categories: {
      type: Array,
      required: true,
    }
  }
}
</script>