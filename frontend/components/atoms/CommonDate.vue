<template>
  <div :style="{'font-size': '15px'}">
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
  },
}
</script>
