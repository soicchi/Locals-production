<template>
  <div :style="fontSize">
    {{ createDate }}
  </div>
</template>

<script>
export default {
  props: {
    date: {
      type: String,
      required: true,
    },
  },
  computed: {
    createDate () {
      return this.$dateFns.format(this.date, 'yyyy/MM/dd HH:mm')
    },
    fontSize () {
      return this.$vuetify.breakpoint.xs ? { 'font-size': '10px' } : { 'font-size': '14px' }
    },
  },
}
</script>
