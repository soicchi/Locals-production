<template>
  <div v-if='$vuetify.breakpoint.xs'>
    <p
      class='mb-0'
      :style='mainFontSize'
    >
      {{ post.restaurant_name }}
    </p>
    <p
      class='mb-0'
      :style='subFontSize'
    >
      最寄り駅: {{ post.station }}
    </p>
  </div>
  <p
    v-else
    :style='mainFontSize'
  >
    {{ post.restaurant_name }}<span :style='subFontSize'>/最寄り駅: {{ post.station }}</span>
  </p>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    },
  },
  computed: {
    mainFontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '24px' } : { 'font-size': '34px'}
    },
    subFontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '12px' } : { 'font-size': '18px' }
    }
  }
}
</script>