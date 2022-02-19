<template>
  <div>
    <v-col
      cols="12"
      class="py-7"
    >
      <AtomsCommonTitle :title="title" />
    </v-col>
    <OrganismsBookMarkPage />
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
  },
}
</script>
