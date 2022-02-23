<template>
  <iframe
    width="100%"
    height="100%"
    style="border:0"
    loading="lazy"
    allowfullscreen
    :src="`https://www.google.com/maps/embed/v1/place?key=${$config.googleApiKey}
      &q=${restaurantName} ${station}駅 飲食店`"
  >
    >
  </iframe>
</template>

<script>
export default {
  props: {
    restaurantName: {
      type: String,
      required: true,
    },
    station: {
      type: String,
      required: true,
    },
  },
  computed: {
    mapWidth () {
      return this.$vuetify.breakpoint.xs ? '100%' : ''
    },
  },
}
</script>
