<template>
  <div>
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
  }
}
</script>