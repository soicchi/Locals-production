<template>
  <v-text-field
    v-model="setRestaurantName"
    label="お店の名前"
    required
    :prepend-icon="mdiStore"
    placeholder="店名を記入"
    hint="店舗名まで入力"
  />
</template>

<script>
import { mdiStore } from '@mdi/js'

export default {
  props: {
    restaurantName: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    mdiStore,
  }),
  computed: {
    setRestaurantName: {
      get () { return this.restaurantName },
      set (newVal) { return this.$emit('update:restaurant-name', newVal) },
    },
  },
}
</script>
