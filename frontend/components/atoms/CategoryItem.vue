<template>
  <div>
    <template v-if="!$vuetify.breakpoint.xs">
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
    </template>
    <template v-else>
      <v-chip
        v-for="category in categories"
        :key="category.id"
        label
        outlined
        color="subColor"
        class="mr-3"
        x-small
      >
        {{ category.name }}
      </v-chip>
    </template>
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
