<template>
  <v-text-field
    v-model="setStation"
    prepend-icon="mdi-train"
    suffix="駅"
    label="最寄り駅"
    :rules="rules"
  />
</template>

<script>
export default {
  props: {
    station: {
      type: String,
      required: true,
    },
  },
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
