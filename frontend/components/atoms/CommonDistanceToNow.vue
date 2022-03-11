<template>
  <div :style="fontSize">
    {{ distanceToNow }}
  </div>
</template>

<script>
import { ja } from 'date-fns/locale'

export default {
  props: {
    date: {
      type: String,
      required: true,
    },
  },
  computed: {
    distanceToNow () {
      return this.$dateFns.formatDistanceToNow(new Date(this.date), { addSuffix: true, locale: ja })
    },
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '10px' } : { 'font-size': '14px' }
    },
  },
}
</script>
