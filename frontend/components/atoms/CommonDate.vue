<template>
  <div>
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
