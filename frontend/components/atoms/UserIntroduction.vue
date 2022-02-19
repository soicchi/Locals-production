<template>
  <v-sheet
    width="50%"
    color="baseColor"
    class="text-center"
  >
    {{ introduction }}
  </v-sheet>
</template>

<script>
export default {
  props: {
    introduction: {
      type: String,
      required: true,
    },
  },
}
</script>
