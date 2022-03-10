<template>
  <v-container>
    <v-row
      justify="center"
      class="mt-5"
    >
      <AtomsCommonTitle :title="title" />
    </v-row>
    <v-row justify="center">
      <v-col cols="4" class="mt-14 pt-14">
        <OrganismsAdminCategory
          v-model="setCategory"
          :categories="categories"
          :category.sync="setCategory"
          @add-category="addCategory"
          @remove-category="removeCategory"
        />
      </v-col>
      <v-col cols="5">
        <OrganismsAdminPost
          :posts="posts"
          :icon-size="iconSize"
          :sort-val="sortVal"
          :sort-list="sortList"
          @destroy-post="destroyPost"
          @destroy-user="destroyUser"
        />
      </v-col>
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
    categories: {
      type: Array,
      required: true,
    },
    category: {
      type: String,
      required: true,
      default: '',
    },
    iconSize: {
      type: Number,
      required: true,
    },
    sortVal: {
      type: String,
      rquired: true,
      default: '本日',
    },
    sortList: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
  },
  computed: {
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    },
  },
  methods: {
    addCategory () {
      this.$emit('add-category')
    },
    destroyPost (post) {
      this.$emit('destroy-post', post)
    },
    destroyUser (userId) {
      this.$emit('destroy-user', userId)
    },
    removeCategory (categoryId) {
      this.$emit('remove-category', categoryId)
    }
  },
}
</script>
