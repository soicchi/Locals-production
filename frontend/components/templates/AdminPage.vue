<template>
  <v-container>
    <v-row
      justify="center"
      class="mt-5"
    >
      <OrganismsAdminDialog
        v-model="setDialog"
        :dialog.sync="setDialog"
      />
      <AtomsCommonTitle :title="title" />
    </v-row>
    <v-row justify="center">
      <v-col cols="4">
        <OrganismsAdminCategory
          v-model="setCategory"
          :categories="categories"
          :category.sync="setCategory"
          @add-category="addCategory"
          @remove-category="removeCategory"
        />
      </v-col>
      <v-col cols="4">
        <OrganismsAdminPost
          :posts="posts"
          :icon-size="iconSize"
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
    title: {
      type: String,
      required: true,
    },
    dialog: {
      type: Boolean,
      required: true,
      default: true,
    },
    // sortVal: {
    //   type: String,
    //   rquired: true,
    // },
    // sortList: {
    //   type: Array,
    //   required: true,
    // },
  },
  computed: {
    setCategory: {
      get () { return this.category },
      set (newVal) { return this.$emit('update:category', newVal) },
    },
    setDialog: {
      get () { return this.dialog },
      set (newVal) { return this.$emit('update:dialog', newVal) },
    },
    // setSortVal: {
    //   get () { return this.sortVal },
    //   set (newVal) { return this.$emit('update:sortVal', newVal) }
    // },
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
    },
  },
}
</script>
