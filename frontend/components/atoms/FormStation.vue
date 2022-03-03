<template>
  <v-text-field
    v-model="setStation"
    :prepend-icon="mdiTrain"
    suffix="駅"
    label="最寄り駅"
    :rules="rules"
  />
</template>

<script>
import { mdiTrain } from '@mdi/js'

export default {
  props: {
    station: {
      type: String,
      required: true,
    },
  },
  data: () => ({
    mdiTrain,
  }),
  computed: {
    setStation: {
      get () { return this.station },
      set (newVal) { return this.$emit('update:station', newVal) },
    },
    rules () {
      return [
        v => !!v || '',
      ]
    },
  },
}
</script>
