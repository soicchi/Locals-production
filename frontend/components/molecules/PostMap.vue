<template>
  <iframe
    width="600"
    height="520"
    style="border:0"
    loading="lazy"
    allowfullscreen
    :src="`https://www.google.com/maps/embed/v1/place?key=${$config.googleApiKey}
      &q=${restaurantName} ${station}駅`"
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
}
</script>
