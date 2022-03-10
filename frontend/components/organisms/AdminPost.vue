<template>
  <v-container>
    <!-- <v-row justify="end">
      <v-col
        cols="3"
        align-self="center"
      >
        <MoleculesPostSort />
      </v-col>
    </v-row> -->
    <v-row
      v-for="post in posts"
      :key="post.id"
      justify="center"
    >
      <MoleculesAdminPostList
        :post="post"
        :icon-size="iconSize"
        @destroy-post="destroyPost"
        @destroy-user="destroyUser"
      />
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      required: true,
    },
    iconSize: {
      type: Number,
      required: true,
    },
    // sortVal: {
    //   type: String,
    //   required: true,
    //   default: '本日',
    // },
    // sortList: {
    //   type: Array,
    //   required: true,
    // },
  },
  // computed: {
  //   setSortVal: {
  //     get () { return this.sortVal },
  //     set (newVal) { return this.$emit('update:sortVal', newVal) }
  //   }
  // },
  methods: {
    destroyPost () {
      this.$emit('destroy-post', this.post)
    },
    destroyUser () {
      this.$emit('destroy-user', this.post.user.id)
    },
  },
}
</script>
