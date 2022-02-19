<template>
  <v-text-field
    v-model="setRestaurantName"
    label="お店の名前"
    required
    prepend-icon="mdi-store"
    placeholder="店名を記入"
    hint="〜店まで記載してください"
  />
</template>

<script>
export default {
  props: {
    restaurantName: {
      type: String,
      required: true,
    },
  },
  computed: {
    setRestaurantName: {
      get () { return this.restaurantName },
      set (newVal) { return this.$emit('update:restaurant-name', newVal) },
    },
  },
}
</script>
