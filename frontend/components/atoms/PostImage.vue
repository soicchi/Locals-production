<template>
  <v-img
    :src="image"
    height="100%"
    width="100%"
  />
</template>

<script>
export default {
  props: {
    image: {
      type: String,
      required: true,
    },
  },
}
</script>
