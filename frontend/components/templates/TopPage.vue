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
          <OrganismsPostSort
            v-model="setSortVal"
            :sort-val.sync="setSortVal"
            :sort-list="sortList"
          />
        </v-sheet>
      </v-col>
    </v-row>
    <v-col cols="12">
      <AtomsCommonTitle :title="pageTitle" />
    </v-col>
    <OrganismsPostFeed
      :posts="posts"
      :logged-in-user="loggedInUser"
      :icon-size="iconSize"
      :post-card-width="postCardWidth"
      @destroy-post="destroyPost"
    />
  </div>
</template>

<script>
export default {
  props: {
    pageTitle: {
      type: String,
      required: true,
    },
    posts: {
      type: Array,
      required: true,
    },
    loggedInUser: {
      type: Object,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    sortWidth: {
      type: String,
      required: true,
    },
    postCardWidth: {
      type: String,
      required: true,
    },
    sortVal: {
      type: String,
      required: true,
    },
    sortList: {
      type: Array,
      required: true,
    },
  },
  computed: {
    setSortVal: {
      get () { return this.sortVal },
      set (newVal) { return this.$emit('update:sortVal', newVal) },
    },
  },
  methods: {
    destroyPost (post) {
      this.$emit('destroy-post', post)
    },
  },
}
</script>
