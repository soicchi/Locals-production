<template>
  <v-container
    fluid
    class="pt-12"
  >
    <v-row
      align="center"
      justify="center"
    >
      <v-col
        cols="12"
        class="text-center"
      >
        <slot name="form-title" />
      </v-col>
      <v-card
        :width="cardWidth"
        class="pa-6"
      >
        <v-form v-model="setValid">
          <slot name="form-card-content" />
          <v-card-actions class="d-flex justify-center">
            <slot name="form-card-button" />
          </v-card-actions>
        </v-form>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    isValid: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    setValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:is-valid', newVal) },
    },
    cardWidth () {
      return this.$vuetify.breakpoint.xs ? '90%' : '25%'
    }
  },
}
</script>
