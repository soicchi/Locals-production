<template>
  <div>
    <v-row
      justify="center"
      align="center"
      class="mt-5"
    >
      <v-col
        cols="12"
        sm="3"
        md="2"
        xl="2"
      >
        <OrganismsPostSearch />
      </v-col>
      <v-col
        cols="12"
        sm="3"
        md="2"
        xl="1"
        class="pt-11 d-flex justify-center"
      >
        <v-sheet
          color="baseColor"
          :width="sortWidth"
        >
          <OrganismsPostSort />
        </v-sheet>
      </v-col>
    </v-row>
    <v-col cols="12">
      <AtomsCommonTitle :title="title" />
    </v-col>
    <OrganismsPostFeed :posts="posts" />
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    },
    posts: {
      type: Array,
      required: true,
    },
  },
  computed: {
    sortWidth () {
      return this.$vuetify.breakpoint.xs ? '40%' : '100%'
    },
  },
}
</script>
