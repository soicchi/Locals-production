<template>
  <v-img
    :src="image"
    height="200px"
    width="200px"
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
